class JobsController < ApplicationController
  before_action :set_job, only: [:show, :close, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @request = Request.new
    @favourite = Favourite.new
    @jobs = policy_scope(Job).order(created_at: :desc)
    filter_title_sector
    filter_pay
    filter_time

    if @jobs
      @markers = @jobs.map do |job|
        {
          lat: job.latitude,
          lng: job.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { job: job })
        }
      end
    end
  end

  def show
    @shift = Shift.new
    @request = Request.new
    @review = Review.new

    if @jobs
      @markers = @job.map do |job|
        {
          lat: job.latitude,
          lng: job.longitude
        }
      end
    end
  end

  def new
    @job = Job.new
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    sector_ids = params[:job][:sector_ids].drop(1)
    @sectors = sector_ids.map do |element|
      Sector.find(element)
    end
    @job.sectors = @sectors
    @job.user = current_user
    authorize @job
    if @job.save
      sleep 3
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job.update(job_params)
    if @job.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def close
    @job.done = true
    authorize @job
    @job.save
    redirect_to dashboard_employer_path(@job.user)
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :location, :summary, :sector_ids)
  end

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def filter_pay
    if params[:my_range].present?
      @lower_pay = params[:my_range].split(";").first.to_i * 100
      @higher_pay = params[:my_range].split(";").last.to_i * 100

      @jobs = @jobs.select do |job|
        job.shifts.pluck(:price_cents).any? { |pay| (pay > @lower_pay) && (pay < @higher_pay) } &&
          job.shifts.select { |shift| (shift.price_cents > @lower_pay) && (shift.price_cents < @higher_pay) }.any? { |shift| !shift.completed }
      end
    end
    @jobs
  end

  def filter_time
    if params[:start_time].present?
      lower_start_time = params[:start_time].split(";").first.to_i / 1000 + 3600
      higher_start_time = params[:start_time].split(";").last.to_i / 1000 + 3600
      base_date = Time.parse("1 January 1970")
      @lower_start_date = base_date + lower_start_time
      @higher_start_date = base_date + higher_start_time

      @jobs = @jobs.select do |job|
        job.shifts.pluck(:start_time).any? { |start| start > @lower_start_date && start < @higher_start_date }
      end
    end
    @jobs
  end

  def filter_title_sector
    if params[:search].present?
      @jobs = @jobs.kinda_matching(params[:search][:query]) unless params.dig(:search, :query).blank?
      @jobs = @jobs.search_by_sector(params[:search][:sectors].reject(&:blank?)) if params.dig(:search, :sectors)&.reject(&:blank?)&.any?
      @jobs = @jobs.kinda_matching(params[:search][:query]) unless params.dig(:search, :query).blank?
    end
    @jobs
  end
end

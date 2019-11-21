class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @request = Request.new
    if params[:search].present?
      @jobs = policy_scope(Job).order(created_at: :desc).kinda_matching(params[:search][:query])
    else
      @jobs = policy_scope(Job).order(created_at: :desc)
    end

    @markers = @jobs.map do |job|
      {
        lat: job.latitude,
        lng: job.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { job: job })
      }
    end
  end

  def show
    @shift = Shift.new
    @request = Request.new
    @review = Review.new

    @markers = {
        lat: @job.latitude,
        lng: @job.longitude
      }

  end

  def new
    @job = Job.new
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    authorize @job
    if @job.save
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

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :location)
  end

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end
end

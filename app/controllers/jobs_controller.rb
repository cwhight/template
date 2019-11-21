class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @request = Request.new
    if params[:search][:query].present?
      @jobs = policy_scope(Job).order(created_at: :desc).kinda_matching(params[:search][:query])
    else
      @jobs = policy_scope(Job).order(created_at: :desc)
    end

    redirect_to dashboard_employer_path(current_user) if current_user.employer
  end

  def show
    @shift = Shift.new
    @request = Request.new
    @review = Review.new
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
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job.update(job_params)
    if @job.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @job.destroy
    redirect_to root_path
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

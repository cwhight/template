class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def show
    authorize @shift
  end

  def new
    @shift = Shift.new
  end

  def create
    @job = Job.find(params[:job_id])
    @shift = Shift.new(shift_params)
    @shift.title = @job.title
    @shift.job = @job
    @shift.total_pay = ((@shift.price.fractional.to_f / 100) * ((Time.parse(@shift.end_time) - Time.parse(@shift.start_time)) / 3600))
    if @shift.save
      redirect_to job_path(@job)
    else
      redirect_to job_path(@job), alert: "Did not save"
    end
    authorize @job
    authorize @shift
  end

  def edit
  end

  def update
    @shift.update(shift_params)
    @shift.total_pay = ((@shift.price.fractional.to_f / 100) * ((Time.parse(@shift.end_time) - Time.parse(@shift.start_time)) / 3600))
    if @shift.save
      redirect_to job_path(@shift.job)
    else
      render :new
    end
    authorize @shift
  end

  def close_shifts
    CloseShiftsJob.perform_later
    authorize Shift
    redirect_to dashboard_employer_path(current_user)
  end

  def destroy
    @shift.destroy
    redirect_to job_path(@shift.job)
  end

  def accept_request
    @request = Request.find(params[:id])
    @shift = @request.shift
    @user = @request.user
    @shift.user = @user
    authorize @shift
    if @shift.save
      redirect_to job_path(@shift.job)
    else
      redirect_to request_path(@request), notice: "did not save"
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :job_id, :price, :total_pay)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end
end

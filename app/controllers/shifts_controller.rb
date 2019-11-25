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
    authorize @job
    authorize @shift
    if @shift.save
      redirect_to job_path(@job)
    else
      redirect_to job_path(@job), alert: "Did not save"
    end
  end

  def edit
  end

  def update
    authorize @shift
    @shift.update(shift_params)
    if @shift.save
      redirect_to job_path(@shift.job)
    else
      render :new
    end
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
    # authorize @request
    if @shift.save
      redirect_to job_path(@shift.job)
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :job_id, :price)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end
end

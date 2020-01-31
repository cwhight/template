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
    if @shift.save
      redirect_to job_path(@shift.job)
    else
      render :new
    end
    authorize @shift
  end

  def close_shifts
    @shifts = Shift.all
    authorize Shift
    @shifts.each do |shift|
      if Time.parse(shift.start_time) < DateTime.now
        shift.update_attribute(:completed, true)
        shift.requests.each { |request| request.update_attribute(:completed, true) }
      end
    end
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
    if @shift.save!
      redirect_to job_path(@shift.job)
    else
      redirect_to request_path(@request), notice: "did not save"
    end
  end

  def upcoming_shifts
    @shifts = current_user.shifts
    authorize @shifts
  end

  def historic_shifts
    @shifts = current_user.shifts
    authorize @shifts
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :job_id, :price, :total_pay)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end
end

# def upcoming_shifts_to_json
#   upcoming_shifts_json = []
#   return unless current_user.employer == false

#   current_user.shifts.select { |shift| shift.start_time >= DateTime.now }.each do
#     upcoming_shift_json = {
#       title: shift.title,
#       start_time: shift.start_time,
#       end_time: shift.end_time
#     }

#     upcoming_shift_json << upcoming_shifts_json

#     return upcoming_shifts_json
#   end
# end


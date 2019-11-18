class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @shift.update(shift_params)
    redirect_to root_path
  end

  def destroy
    @shift.destroy
    redirect_to root_path
  end

  private

  def shift_params
    params.require(:shift).permit(:pay, :start_time, :end_time)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end
end

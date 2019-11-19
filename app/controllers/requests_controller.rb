class RequestsController < ApplicationController
  before_action :set_application, only: [:show]

  def show
  end

  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    @request.user = current_user
    @request.shift = Shift.find(params[:shift_id])
    if @request.save

      redirect_to root_path
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:title, :content, :shift_id)
  end

  def set_request
    @request = Request.find(params[:id])
  end
end

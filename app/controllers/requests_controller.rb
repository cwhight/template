class RequestsController < ApplicationController
  before_action :set_request, only: [:show]

  def show
    authorize @request
    @chat = Chat.new
  end

  def new
    @request = Request.new
    authorize @request
  end

  def confirmation
    @shift = Shift.find(params[:shift_id])
    @job = Job.find(params[:job_id])
    @request = Request.new(content: params[:request][:content])
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    @request.user = current_user
    @request.shift = Shift.find(params[:shift_id])
    if @request.save
      redirect_to dashboard_path(current_user)
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

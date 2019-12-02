class RequestsController < ApplicationController
  before_action :set_request, only: [:show]

  def show
    authorize @request
    @chat = @request.chat
    @message = Message.new
    # mark_as_read(@chat)
  end

  def new
    @shift = Shift.find(params[:shift_id])
    @job = Job.find(params[:job_id])

    @request = Request.new

    @markers = [{
      lat: @job.latitude,
      lng: @job.longitude
    }]

    authorize @request
  end

  # def confirmation
  #   @shift = Shift.find(params[:shift_id])
  #   @job = Job.find(params[:job_id])

  #   @request = Request.new

  #   @markers = [{
  #     lat: @job.latitude,
  #     lng: @job.longitude
  #   }]

  #   authorize @request
  # end

  def create
    @request = Request.new(request_params)
    authorize @request
    @request.user = current_user
    @request.completed = false
    @request.shift = Shift.find(params[:shift_id])
    if @request.save
      @chat = Chat.new
      @chat.request = @request
      @chat.employee = @request.user
      @chat.employer = @request.shift.job.user
      if @chat.save
        @message = Message.new
        @message.chat = @chat
        @message.content = @request.content
        @message.user = @request.user
        if @message.save
          sleep 3
          redirect_to dashboard_path(current_user)
        end
      end
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:title, :content, :completed, :shift_id)
  end

  def set_request
    @request = Request.find(params[:id])
  end
end

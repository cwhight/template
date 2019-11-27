class ChatsController < ApplicationController

  def index
    @chats = policy_scope(Chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    authorize @chat
  end

  def new
    @chat = Chat.new
    authorize @chat
  end

  def create
    @chat = Chat.new
    @request = Request.find(params[:request_id])
    @chat.request = @request
    authorize @chat
    if @chat.save
      redirect_to chat_path(@chat)
    end
    # Pusher.trigger('chat-channel','new-chat', {
    #   comment: @chat.message
    # })
    # redirect_to chats_path
  end

  private
    def chat_params
      params.require(:chat).permit(:message)
    end
end

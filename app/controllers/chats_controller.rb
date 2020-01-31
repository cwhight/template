class ChatsController < ApplicationController

  def index
    @chats = policy_scope(Chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    authorize @chat
    mark_as_read(@chat)
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
  end

  def inbox_show
    @chat = Chat.find(params[:id])
    @message = Message.new
    authorize @chat
    mark_as_read(@chat)
  end

  def inbox
    @chats = current_user.chats
    authorize @chats
  end

  def mark_as_read(chat)
    chat.messages.select {|message| message.user != current_user }.each {|message| message.update(read: true)}
  end

  private
    def chat_params
      params.require(:chat).permit(:message)
    end
end

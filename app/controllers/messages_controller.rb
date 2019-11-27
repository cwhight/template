class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @chat = Chat.find(params[:chat_id])
    @message.chat = @chat
    @user = current_user
    @message.user = @user
    authorize @message
    @message.save
      # broadcasting messages using pusher
      Pusher.trigger('message-channel','new-message', {
        message: @message.content
      })
    redirect_to chat_path(@chat)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end

class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @chat = Chat.find(params[:chat_id])
    @message.chat = @chat
    @user = current_user
    @message.user = @user
    authorize @message
    if @message.save
      Pusher.trigger('message-channel', 'new-message', {
        content: @message.content,
        user: @message.user.first_name,
        sent: @message.created_at.strftime("%H:%M")
      })

      redirect_to chat_path(@chat)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end

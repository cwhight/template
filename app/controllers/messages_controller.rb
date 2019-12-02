class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @chat = Chat.find(params[:chat_id])
    @message.chat = @chat
    @user = current_user
    @message.user = @user
    authorize @message
    @message.read ? read = "<i class='fas fa-check'></i>" : read = ""
    if @message.save
      Pusher.trigger("#{@chat.id}-channel", 'new-message', {
        content: @message.content,
        user: @message.user.first_name,
        sent: @message.created_at.strftime("%H:%M"),
        read: read,
        sender: @message.user.id
      })
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end

class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user).order(created_at: 'DESC')
    @message = Message.new

  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)

    if @message.save
      redirect_to room_messages_path(@room)
    else
      @room.messages.includes(:user).order(created_at: 'DESC')
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
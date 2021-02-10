class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, #メッセージを送れるのはcurrent_user
                   room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message)
                        .permit(:user_id, :room_id, :content, :image)
                        .merge(user_id: current_user.id))
    else
      flash[:allert] = "メッセージを送信できませんでした"
    end
    # redirect_to "/rooms/#{@message.room_id}"
    ActionCable.server.broadcast 'room_channel', message: @message.template
  end
end

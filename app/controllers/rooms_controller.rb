class RoomsController < ApplicationController
  before_action :authenticate_user!
  layout 'no_footer'

  def index
    
  end

  def create
    @room = Room.create(user_id: current_user.id)#現在ログインしているユーザーのentry
    @entry1 = Entry.create(room_id: @room.id, 
                            user_id: current_user.id)#fields_forから送られてきたparams(:user_id, room_id)を許可する
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id]) #1つのメッセージルームを表示する
    #ログインしているユーザーとそれに紐づくroom.idを探す
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages #@roomと紐づいたメッセージを表示する
      @message = Message.new #messageのインスタンスを作成するため
      @entries = @room.entries #ユーザーの名前などの情報を表示するため
    else
      # redirect_back(fallback_location: root_path) #前のページに戻す
    end
  end

  def show_additionally
    last_id = params[:oldest_message_id].to_i - 1
    @messages = Message.includes(:user).order(:id).where(id: 1..last_id).last(50)
  end
end

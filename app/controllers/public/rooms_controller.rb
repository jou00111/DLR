class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create(name: "Room #{SecureRandom.hex(4)}")
    @entry = ChatRoom.create(user_id: current_user.id, room_id: @room.id)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats.order(created_at: :asc)
    @chat = Chat.new
  end
end

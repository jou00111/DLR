class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_room, only: [:show, :destroy_room]

  # すべてのチャットルーム一覧を表示
  def index
    @rooms = Room.includes(:chats, :users).all
  end

  # 特定のチャットルームの詳細を表示
  def show
    @chats = @room.chats.order(created_at: :asc)
    @chat = Chat.new(room_id: @room.id)
  end

 def create
    @chat = Chat.new(chat_params)

    if current_user
      @chat.user_id = current_user.id  # ユーザーが送信
    elsif current_admin
      @chat.admin_id = current_admin.id  # 管理者が送信
    end

    if @chat.save
      redirect_to admin_chat_path(@chat.room), notice: "メッセージを送信しました"
    else
      @room = @chat.room
      @chats = @room.chats.order(created_at: :asc)
      flash.now[:alert] = "メッセージの送信に失敗しました"
      render :show
    end
  end

  # チャットルームの削除
  def destroy_room
    @room.destroy
    redirect_to admin_chats_path, notice: "チャットルームを削除しました"
  end

  # メッセージの検索機能
  def search
    @chats = Chat.where("message LIKE ?", "%#{params[:keyword]}%").includes(:room, :user)
  end

  private

  # チャットルームを設定
  def set_room
    @room = Room.find(params[:id])
  end

  # チャットのパラメータを許可
  def chat_params
    params.require(:chat).permit(:message, :room_id, :user_id, :admin_id)
  end
end




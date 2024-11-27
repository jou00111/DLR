class Public::ChatsController < ApplicationController
  # チャットルームの表示
  def show
    # チャット相手のユーザーを取得
    @user = User.find(params[:id])

    # 現在のユーザーが参加しているチャットルームの一覧を取得
    rooms = current_user.chat_rooms.pluck(:room_id)

    # 相手ユーザーとの共有チャットルームが存在するか確認
    chat_rooms = ChatRoom.find_by(user_id: @user.id, room_id: rooms)

    unless chat_rooms.nil?
      # 共有チャットルームが存在する場合、そのチャットルームを表示
      @room = chat_rooms.room
    else
      # 共有チャットルームが存在しない場合、新しいチャットルームを作成
      @room = Room.new(user_id: current_user.id)  # ここでuser_idを設定
      @room.save

      # チャットルームに現在のユーザーと相手ユーザーを追加
      ChatRoom.create(user_id: current_user.id, room_id: @room.id)
      ChatRoom.create(user_id: @user.id, room_id: @room.id)
    end
  
    # チャットルームに関連付けられたメッセージを取得
    @chats = @room.chats

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)  # ここで新しい空のメッセージオブジェクトを作成
  end  

  # チャットメッセージの送信
    def create
    # フォームから送信されたメッセージを取得し、現在のユーザーに関連付けて保存
    @chat = current_user.chats.new(chat_params)

    # バリデーションに合格しない場合はエラーを表示
    render :validate unless @chat.save
  end

  # チャットメッセージの削除
  def destroy
    # ログイン中のユーザーに関連するチャットメッセージを削除
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  private

  # フォームから送信されたパラメータを安全に取得
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end

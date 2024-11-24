class Room < ApplicationRecord
    has_many :chat_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :users, through: :chat_rooms
end

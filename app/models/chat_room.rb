class ChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :user_id, uniqueness: { scope: :room_id } # 同じユーザーが同じ部屋に重複して参加しないように
end

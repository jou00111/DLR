class PostComment < ApplicationRecord
 #アソシエーション
belongs_to :user
belongs_to :post

#バリデーション
validates :title, presence: true
validates :body, presence: true


end

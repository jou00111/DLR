class Post < ApplicationRecord
  #アソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  #画像
  has_one_attached :image

 #公開ステータス
  def status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
end

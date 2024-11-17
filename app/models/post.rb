class Post < ApplicationRecord
  #アソシエーション
  has_many :post_comments, dependent: :destroy
  belongs_to :user

  #バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :is_active, inclusion: { in: [true, false] }
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

  def active_for_authentication?
    super && (is_active == true)
  end
end

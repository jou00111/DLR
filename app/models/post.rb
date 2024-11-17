class Post < ApplicationRecord
  scope :visible, -> { where(is_active: true) } # 公開投稿を取得
  #アソシエーション
  has_many :post_comments, dependent: :destroy
  belongs_to :user

  #バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  #画像
  has_one_attached :image

  #検索条件(投稿側)
  def self.search_for(word, search)
    if search == 'perfect'
      Post.where(title: word)
    elsif search == 'forward'
      Post.where('title LIKE ?', word + '%')
    elsif search == 'backward'
      Post.where('title LIKE ?','%'+ word)
    else
      Post.where('title LIKE ?','%' + word + '%')
    end
  end



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

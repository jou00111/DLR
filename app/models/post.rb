class Post < ApplicationRecord
  #アソシエーション
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

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
  def save_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end
end

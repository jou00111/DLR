class Post < ApplicationRecord
  scope :visible, -> { where(is_active: true) }

  # アソシエーション
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validate :image_count_within_limit  # カスタムバリデーション

  # 画像
  has_many_attached :image

  def save_tags(tag_lists)
    # 古いタグを消す
    self.post_tags.destroy_all

    # 新しいタグを保存
    tag_lists.uniq.each do |t|  # 重複するタグを除外
      tag = Tag.find_or_create_by(name: t)
      self.tags << tag unless self.tags.include?(tag)  # タグが関連付け済みでない場合のみ追加
    end
  end

  def image_count_within_limit
    if image.attachments.size > 3
      errors.add(:image, "は3枚までアップロードできます")
    end
  end
  def admin?
    self.email == "123@456"  # 例えば、emailで管理者を判定
  end

  def status
    if is_active
      "販売中"
    else
      "販売停止中"
    end
  end

  # 検索条件(投稿側)
  def self.search_for(word, search,current_user)
      if current_user
        # current_userが存在する場合（ログインユーザー）
        case search
        when "perfect_match"
          Post.where("title LIKE ?", "#{word}")
        when "partial_match"
          Post.where("title LIKE ?", "%#{word}%")
        when "forward_match"
          Post.where("title LIKE ?", "#{word}%")
        when "backward_match"
          Post.where("title LIKE ?", "%#{word}")
        else
          Post.visible
        end
      else
        # current_userがnilの場合（未ログインまたは退会したユーザーを含める）
        case search
        when "perfect_match"
          Post.where("title LIKE ?", "#{word}")
        when "partial_match"
          Post.where("title LIKE ?", "%#{word}%")
        when "forward_match"
          Post.where("title LIKE ?", "#{word}%")
        when "backward_match"
          Post.where("title LIKE ?", "%#{word}")
        else
          Post.all  # 退会したユーザーも含めて全てのユーザーを返す
        end
      end
  end

  def active_for_authentication?
    super && (is_active == true)
  end
end

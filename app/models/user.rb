class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 仮想属性
  attr_accessor :current_password      
  attr_accessor :change_password

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  
  

  # バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence: true
  validates :specify_field, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :email, presence: true

  # 画像
  has_one_attached :profile_image

  # 検索条件(ユーザー側)
  def self.search_for(word, search)
    case search
    when 'perfect'
      User.where(name: word)
    when 'forward'
      User.where('name LIKE ?', word + '%')
    when 'backward'
      User.where('name LIKE ?', '%' + word)
    else
      User.where('name LIKE ?', '%' + word + '%')
    end
  end

  # デフォルトの画像設定
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end
  
  def user_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end
  
  
  # is_activeがtrueならfalseを返す
  def active_for_authentication?
    super && (is_active == true)
  end
end

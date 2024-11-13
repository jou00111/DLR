class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  #バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence: true
  validates :introduction, presence: true
  validates :specify_field, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :email, presence:true

  #デフォルトの画像設定
  def get_profile_image
    unless profile_image.attached?
      file_path = rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type:'image/jpeg')
    end
    image
  end
  # is_activeがtrueならfalseを返すようにしている
  def active_for_authentication?
    super && (is_active == true)
  end

end
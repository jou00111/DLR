class PostComment < ApplicationRecord
   #アソシエーション
    belongs_to :user, optional: true
    belongs_to :post
    belongs_to :admin, optional: true

    #バリデーション
    validates :title, presence: true
    validates :body, presence: true
    validates :user, presence: true, if: :user_comment?
    validates :admin, presence: true, if: :admin_comment?

  def user_comment?
    user.present?
  end

  def admin_comment?
    admin.present?
  end
end

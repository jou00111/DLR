class AddAdminIdToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :admin_id, :integer
  end
end

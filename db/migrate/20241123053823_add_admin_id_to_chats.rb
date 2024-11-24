class AddAdminIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :admin_id, :integer
  end
end

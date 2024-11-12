class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer  :user_id,      null: false #外部キー
      t.string   :title,       null: false #タイトル
      t.string   :body,        null: false #本文
      t.boolean  :is_active,   null: true     



      t.timestamps
    end
  end
end

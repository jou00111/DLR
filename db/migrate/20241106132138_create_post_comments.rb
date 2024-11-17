class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.integer :user_id,    null: false #外部キー
      t.integer :post_id,    null: false #外部キー
      t.string  :star,       null: false #星
      t.string  :title,      null: false #タイトル
      t.string  :body,       null: false #本文
      t.boolean :is_active,  null: false, default: true #公開ステータス

      t.timestamps
    end
  end
end

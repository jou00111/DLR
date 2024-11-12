class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|

      t.integer :user_id,     null: false #外部キー
      t.integer :tag_id,      null: false #外部キー
      t.timestamps
    end
    add_index :post_tags, [:post_tag_id,:tag_id],unique: true
  end
end

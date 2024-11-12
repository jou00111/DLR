class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|

      t.references :user_id,     null: false,foreign_key: true #外部キー
      t.references :tag_id,      null: false,foreign_key: true #外部キー
      t.timestamps
    end
    add_index :post_tags, [:post_tag_id,:tag_id],unique: true
  end
end

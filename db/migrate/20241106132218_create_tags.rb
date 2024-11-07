class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      
      t.string :name,   null: false #名前カラム
      t.timestamps
    end
  end
end

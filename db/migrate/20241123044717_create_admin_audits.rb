class CreateAdminAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_audits do |t|
      t.integer :admin_id
      t.string :action
      t.integer :target
      t.datetime :timestamp

      t.timestamps
    end
  end
end

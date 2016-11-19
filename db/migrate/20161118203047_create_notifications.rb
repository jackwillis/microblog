class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :subject_id, null: false
      t.string :subject_type, null: false
      t.integer :user_id, null: false
      t.datetime :read_at

      t.timestamps
    end
    add_index :notifications, :subject_id
    add_index :notifications, :subject_type
    add_index :notifications, :user_id
  end
end

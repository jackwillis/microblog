class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :leader_id

      t.timestamps
    end
    add_index :follows, :follower_id
    add_index :follows, :leader_id
  end
end
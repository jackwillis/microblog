class CreateUsernameMentions < ActiveRecord::Migration[5.0]
  def change
    create_table :username_mentions do |t|
      t.integer :post_id, null: false
      t.integer :mentioned_id, null: false

      t.timestamps
    end
    add_index :username_mentions, :post_id
    add_index :username_mentions, :mentioned_id
  end
end

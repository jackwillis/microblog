class CreatePostLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :post_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
    add_index :post_likes, :post_id
    add_index :post_likes, :user_id

    add_column :posts, :likes_count, :integer, default: 0
    add_column :users, :liked_posts_count, :integer, default: 0
  end
end

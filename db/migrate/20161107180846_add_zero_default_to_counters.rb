class AddZeroDefaultToCounters < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :followers_count, :integer, default: 0
    change_column :users, :leaders_count, :integer, default: 0
    change_column :users, :posts_count, :integer, default: 0
  end
end

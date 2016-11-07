class AddFollowCountersToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :follower_count, :integer
    add_column :users, :leader_count, :integer
  end
end

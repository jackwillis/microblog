class CorrectlyPluralizeFollowerCounts < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :follower_count, :followers_count
    rename_column :users, :leader_count, :leaders_count
  end
end

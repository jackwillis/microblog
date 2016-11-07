class Follow < ApplicationRecord
  belongs_to :leader, {
    class_name: :User,
    counter_cache: :follower_count
  }

  belongs_to :follower, {
    class_name: :User,
    counter_cache: :leader_count
  }
end

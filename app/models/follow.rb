class Follow < ApplicationRecord
  belongs_to :leader, {
    class_name: :User,
    counter_cache: :followers_count
  }

  belongs_to :follower, {
    class_name: :User,
    counter_cache: :leaders_count
  }
end

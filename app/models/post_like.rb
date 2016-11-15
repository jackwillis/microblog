class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user, counter_cache: :liked_posts_count
end

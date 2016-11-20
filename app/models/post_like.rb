class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user, counter_cache: :liked_posts_count

  has_one :notification, as: :subject, dependent: :destroy

  after_create :create_notifications

  private

  def create_notifications
    return if user_id == post.user_id
    Notification.create(subject: self, user_id: post.user_id)
  end
end

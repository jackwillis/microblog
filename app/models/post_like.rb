class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user, counter_cache: :liked_posts_count

  has_one :notification, as: :subject, dependent: :destroy

  after_create :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: post.user)
  end
end

class Follow < ApplicationRecord
  belongs_to :leader, {
    class_name: :User,
    counter_cache: :followers_count
  }

  belongs_to :follower, {
    class_name: :User,
    counter_cache: :leaders_count
  }
  
  has_one :notification, as: :subject, dependent: :destroy

  after_create :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: leader)
  end
end

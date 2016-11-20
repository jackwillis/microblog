class UsernameMention < ApplicationRecord
  belongs_to :mentioned, class_name: 'User', foreign_key: :mentioned_id
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user_id: mentioned_id)
  end
end

class Notification < ApplicationRecord
  belongs_to :user

  belongs_to :subject, polymorphic: true

  belongs_to :post_like, class_name: 'PostLike', foreign_key: :subject_id
  belongs_to :follow, class_name: 'Follow', foreign_key: :subject_id

  scope :with_polymorphic_preloads, -> {
    preload(post_like: [:post, :user], follow: [:follower])
  }

  scope :unread, -> { where(read_at: nil) }
  scope :read, -> { where.not(read_at: nil) }

  def unread?
    read_at.nil?
  end

  def read?
    !read_at.nil?
  end
end

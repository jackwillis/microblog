class Post < ApplicationRecord
  has_many :hashtag_indices, dependent: :destroy
  after_create :create_hashtag_indices
  
  belongs_to :user, counter_cache: true

  self.per_page = 20

  scope :with_hashtag, -> (hashtag) {
    joins(:hashtag_indices).where(hashtag_indices: { hashtag: hashtag })
  }

  scope :followed_posts_for, -> (user) {
    joins(:user).where(users: { id: user.leaders })
  }

  def hashtags
    body.scan(/\#(\w+)/).map { |h| h[0].downcase }.uniq
  end

  private
  def create_hashtag_indices
    HashtagIndex.create(hashtags.map { |hashtag|
      {
        post_id: id,
        hashtag: hashtag
      }
    })
  end
end

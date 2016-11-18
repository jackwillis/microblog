class Post < ApplicationRecord
  before_create :create_token
  def to_param; token; end

  # Users
  #
  belongs_to :user, counter_cache: true

  # Pagination
  #
  self.per_page = 20

  # Likes
  #
  has_many :post_likes, dependent: :destroy

  scope :likes_for, -> (user) {
    where(id: user.post_likes.select(:post_id))
  }

  # Hashtags
  #
  has_many :hashtag_indices, dependent: :destroy
  after_create :create_hashtag_indices

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

  def create_token
    self.token = 10.times.map { SecureRandom.random_number(9) }.join
  end
end

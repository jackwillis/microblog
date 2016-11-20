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
  after_create :create_hashtag_indices, :create_username_mentions

  scope :with_hashtag, -> (hashtag) {
    joins(:hashtag_indices).where(hashtag_indices: { hashtag: hashtag })
  }

  scope :followed_posts_for, -> (user) {
    leaders_posts = joins(:user).where(users: { id: user.leaders })
    my_posts = joins(:user).where(users: { id: user })

    leaders_posts.or(my_posts)
  }

  def hashtags
    body.scan(/\#(\w+)/).map { |h| h[0].downcase }.uniq
  end

  def mentioned_usernames
    body.scan(/\@(\w+)/).map { |h| h[0].downcase }.uniq
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

  def create_username_mentions
    UsernameMention.create(mentioned_usernames.map { |username|
      {
        post_id: id,
        mentioned: User.find_by(username: username)
      }
    })
  end

  def create_token
    self.token = 10.times.map { SecureRandom.random_number(9) }.join
  end
end

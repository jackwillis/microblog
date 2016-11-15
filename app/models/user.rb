class User < ApplicationRecord
  def to_param; username; end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts, dependent: :destroy

  has_many :post_likes, {
    dependent: :destroy,
    counter_cache: :liked_posts_count
  }

  def like(post)
    PostLike.find_or_create_by(user: self, post: post)
  end

  def unlike(post)
    PostLike.find_by(user: self, post: post)&.destroy
  end

  def likes?(post)
    post_likes.exists?(post: post)
  end

  def liked_posts
    Post.likes_for(self)
  end

  has_many :followerships, {
    class_name: :Follow,
    foreign_key: :leader_id,
    dependent: :destroy
  }

  has_many :leaderships, {
    class_name: :Follow,
    foreign_key: :follower_id,
    dependent: :destroy
  }

  def follow(other)
    Follow.find_or_create_by(follower: self, leader: other)
  end

  def unfollow(other)
    Follow.find_by(follower: self, leader: other)&.destroy
  end

  def follows?(other)
    leaderships.exists?(leader: other)
  end

  def leads?(other)
    other.follows?(self)
  end

  def followers
    User.joins(:leaderships).where(follows: { leader_id: id })
  end

  def leaders
    User.joins(:followerships).where(follows: { follower_id: id })
  end

  def following; leaders; end
  def following_count; leaders_count; end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts

  has_many :followerships, class_name: :Follow, foreign_key: :leader_id
  has_many :leaderships, class_name: :Follow, foreign_key: :follower_id

  def follow(other)
    return true if follows?(other)

    Follow.create(follower: self, leader: other)
  end

  def unfollow(other)
    return true unless follows?(other)

    Follow.where(follower: self, leader: other).delete_all
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

  alias_method :following, :leaders
end

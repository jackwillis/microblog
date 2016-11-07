class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts, dependent: :destroy

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

  def to_param; username; end

  def follow(other)
    return true if follows?(other)

    Follow.create(follower: self, leader: other)
  end

  def unfollow(other)
    followship = Follow.where(follower: self, leader: other).first

    return true unless followship

    followship.destroy
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
  def following_count; leader_count; end
end

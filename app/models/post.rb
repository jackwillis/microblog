class Post < ApplicationRecord
  has_many :hashtag_indices

  after_create :create_hashtag_indices

  scope :with_hashtag, -> (hashtag) {
    joins(:hashtag_indices).where(hashtag_indices: { hashtag: hashtag })
  }

  def hashtags
    body.scan(/\#(\w+)/).map { |h| h.first.downcase }
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

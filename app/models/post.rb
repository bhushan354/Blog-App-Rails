class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :increment_posts_number
  after_destroy :decrement_posts_number

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_posts_number
    # belongs_to :author at top hence
    author.update(posts_counter: author.posts_counter + 1)
  end

  def decrement_posts_number
    author.update(posts_counter: author.posts_counter - 1)
  end
end

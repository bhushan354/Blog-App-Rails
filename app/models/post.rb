class Post < ApplicationRecord
  # imp
  # Post model has a foreign key named author_id that corresponds to the id column of the User model
  # class_name: 'User' option specifies the name of the associated model, which is User in this case
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_save :update_user_posts_number

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_user_posts_number
    author.update(posts_counter: author.posts.count)
  end
end

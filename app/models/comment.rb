# The belongs_to association in the Comment model establishes a connection between the Comment model and the Post model
class Comment < ApplicationRecord
  # These lines establish associations between the Comment model and the Post and User models
  belongs_to :post
  # This association indicates that a comment belongs to a single post
  belongs_to :user
  # alias_attribute method in Ruby on Rails is used to create an alias (an alternative name) for an attribute in a model
  alias_attribute :author, :user
  alias author user

  # sets up a callback that triggers the update_comments_counter method after a new comment is created
  after_create :update_comments_number
  validates :author, presence: true
  validates :text, presence: true

  def update_comments_number
    # this 'post' is model not table thats why it is written in singular (it is updating the count of single post)
    post.update(comments_counter: post.comments.count)
  end
end

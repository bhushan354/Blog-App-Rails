class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  alias_attribute :author, :user

  after_create :increment_comments
  before_destroy :decrement_comments

  # after_create :update_comments_counter
  validates :author, presence: true
  validates :text, presence: true

  # def update_comments_counter
  #   post.update(comments_counter: post.comments.count)
  # end


  private

  def increment_comments
    post.increment!(:comments_counter)
  end

  def decrement_comments
    post.decrement!(:comments_counter)
  end
end

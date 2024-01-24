class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  alias_attribute :author, :user

  after_create :update_comments_counter
  validates :author, presence: true
  validates :text, presence: true

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end

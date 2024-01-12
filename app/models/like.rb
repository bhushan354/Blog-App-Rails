class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_save :update_likes_counter

  validates :user, uniqueness: { scope: :post }

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
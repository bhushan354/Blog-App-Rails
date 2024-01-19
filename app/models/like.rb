class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_save :update_likes_counter
  after_destroy :update_likes_counter

  validates :user, uniqueness: { scope: :post }

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

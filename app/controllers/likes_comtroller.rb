class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    Like.create(user: current_user, post:)
    redirect_back(fallback_location: user_post_path(post.author, post))
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy
    redirect_back(fallback_location: user_post_path(like.post.author, like.post))
  end
end

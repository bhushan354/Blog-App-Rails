class LikesController < ApplicationController
  def create
    post = Post.includes(:likes).find(params[:post_id])
    @like = Like.create(user: current_user, post:)
    if @like.save
      flash[:notice] = 'Like created successfully'
      redirect_back(fallback_location: user_post_path(post.author, post))
    else
      flash.now[:error] = "Error: Couldn't create liket"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy
    redirect_back(fallback_location: user_post_path(like.post.author, like.post))
  end
end

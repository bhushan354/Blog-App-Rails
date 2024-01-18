class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    Comment.create(post_params(post))
    redirect_to user_post_path(current_user, post)
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_user[:post] = post
    a_user
  end
end

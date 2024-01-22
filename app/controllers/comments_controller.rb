class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.create(post_params(post))
    if @comment.save
      flash[:notice] = 'A new comment is added successfully'
      redirect_to user_post_path(current_user, post)
    else
      flash.now[:error] = 'Something went wrong while creating comment'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_post[:post] = post
    a_post
  end
end

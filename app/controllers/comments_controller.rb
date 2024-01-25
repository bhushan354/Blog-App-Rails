class CommentsController < ApplicationController
  # The load_and_authorize_resource method automatically loads the resource (model) based on the controller's actions
  load_and_authorize_resource

  def new
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(post_params(@post))
    if @comment.save
      flash[:notice] = 'A new comment is added successfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Something went wrong while creating comment'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if can_user_remove_comment?(@comment)
      @comment.destroy
      flash[:notice] = 'Comment successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end

    redirect_to user_post_path(@post.author, @post)
  end

  private

  def post_params(post)
    params.require(:comment).permit(:text).merge(author: current_user, post:)
  end

  # current_user is currently authenticate_user
  def can_user_remove_comment?(comment)
    current_user == comment.user || current_user.role == 'admin'
  end
end

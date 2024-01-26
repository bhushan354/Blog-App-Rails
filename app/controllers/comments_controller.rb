class CommentsController < ApplicationController
  # load_and_authorize_resource

  def new
    Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.create(post_params(post))
    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to user_post_path(current_user, post)
    else
      flash.now[:error] = "Error: Couldn't create comment"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if current_user_can_delete_comment?(@comment)
      @comment.destroy
      flash[:notice] = 'Comment successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end

    redirect_to user_post_path(@post.author, @post)
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_post[:post] = post
    a_post
  end

  def current_user_can_delete_comment?(comment)
    current_user == comment.user || current_user.role == 'admin'
  end
end

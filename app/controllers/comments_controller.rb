class CommentsController < ApplicationController
  # The load_and_authorize_resource method automatically loads the corresponding resource (model instance) based on the controller's actions
  # After loading the resource, CanCanCan checks whether the current user has the necessary permissions to perform the action on that resource by using ability class in ability.rb
  load_and_authorize_resource

  def new
    @post = Post.includes(:comments).find(params[:post_id])
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

  def destroy
    comment = Comment.find(params[post.id])
    comment.destroy
    redirect_to {user_posts(current_user)}
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_post[:post] = post
    a_post
  end
end

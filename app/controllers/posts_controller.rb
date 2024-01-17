class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end
end

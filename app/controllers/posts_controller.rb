class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :set_user
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end

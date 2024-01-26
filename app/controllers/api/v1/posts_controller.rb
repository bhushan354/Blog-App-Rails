class Api::V1::PostsController < ApplicationController
    before_action :set_user
    before_action :set_post, only: [:show]
    # http://localhost:3000/api/v1/users/1/posts/all
    # http://localhost:3000/api/v1/users/:user_id/posts/:post_id

    def index
        @posts = @user.posts.includes(:comments, :likes)
        json_response = {
            posts: @posts.as_json(include: {comments: {include: :user}, likes: {}})
        }
        render json: JSON.pretty_generate(json_response)
    end 

    def all
        @posts = Post.all

        json_response = {
            # %i used to exclude attributeasd
            posts: @posts.as_json(except: %i[comments likes]),
        }

        render json: JSON.pretty_generate(json_response)
    end

    def show
        @comments = @post.comments.includes(:user)
        json_response = {
            post: @post.as_json(include: { comments: { include: :user}})
        }
        
        render json.pretty_generate(json_response)
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'No User Found' }, status: :not_found
    end
    
    def set_post
        @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'No Post Found' }, status: :not_found
    end
end
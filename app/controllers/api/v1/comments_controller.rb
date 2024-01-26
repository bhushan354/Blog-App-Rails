class Api::V1::CommentsController < ApplicationController
    
    private
    def set_user
        @user  = User.find(params[:user_id])
    end

    def set_post
        set_user
        @post = @user.posts.find(params[:post_id])
    end

    def set_comments
        set_post
        @comments = @post.comments.includes(:user)
    end

    def comment_params
        params.require(:comment).permit(:text)
    end
end
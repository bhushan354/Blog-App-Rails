class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:comments).find(params[:id])
  end
end

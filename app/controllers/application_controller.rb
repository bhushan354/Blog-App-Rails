class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception: line sets up a security against Cross-Site Request Forgery (CSRF) attacks.
  protect_from_forgery with: :exception

  def current_user
    # "||= "  this is an assignment operator assign value to variable only if they are nil currntely
    @current_user ||= User.first
  end

  # helper_method :current_user: This line declares that the current_user method is also available for use in views
  helper_method :current_user
end

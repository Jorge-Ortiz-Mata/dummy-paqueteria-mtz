class AuthenticatedController < ApplicationController
  before_action :authenticate_user
  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

  def authenticate_user
    redirect_to login_path unless logged_in?
  end

  # This method redirect to the root path if a user is logged in. This is for the login and signup pages.
  def deny_access
    return if session[:user_id].nil?

    redirect_to root_path
  end
end

class ApplicationController < ActionController::Base
  include LoginHelpers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private
  # Simply store our ID in the session
  # and set the current user instance var
  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
    ! session[:user_id].nil? &&
      session[:user_id] == user.id &&
      @current_user == user
  end

  # reverse the sign in...
  def sign_out
    @current_user = nil
    session.delete(:user_id)
    session[:user_id].nil? && @current_user.nil?
  end

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to new_session_path  #< Remember this is a custom route
    end
  end

  def require_current_user
    # don't forget that params is a string!!!
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    end
  end
end

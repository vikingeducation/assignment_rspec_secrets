module ControllerHelper
  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
  end

  def current_user
    User.find(session[:user_id]) if User.exists?(session[:user_id]) && session[:user_id]
  end

  def signed_in_user?
    !!current_user
  end
end

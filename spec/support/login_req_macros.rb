module LoginReqMacros

  def login_as(user)
    post session_path, params: { email: user.email, password: user.password }
  end

  def log_out
    delete session_path
  end

  def current_user
    User.find(session[:user_id]) if User.exists?(session[:user_id]) && session[:user_id]
  end

end

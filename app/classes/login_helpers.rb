# module created to to be included into ApplicationController and view helpers, so that view specs can gain access to these methods

module LoginHelpers
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  # Will turn the current_user into a boolean
  # e.g. `nil` becomes false and anything else true.
  def signed_in_user?
    !!current_user
  end
end

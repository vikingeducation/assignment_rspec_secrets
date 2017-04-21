module HelperMethods
  def current_user
    @current_user
  end
  def signed_in_user?
    !!current_user
  end
end

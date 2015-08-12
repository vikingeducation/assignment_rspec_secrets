module UserMacros

  def update_user(user, new_param)
    put :update,  :id => user.id,
                  :user => attributes_for(:user, new_param)
  end

end
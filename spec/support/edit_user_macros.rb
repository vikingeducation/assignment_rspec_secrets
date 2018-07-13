module EditUserMacros

  def edit_profile(user)
    click_link "#{user.name}"
    click_link("Edit")
  end

  def update_profile(user)
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Update User"
  end

end

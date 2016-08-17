module LoginMacros
  def sign_in(user)
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end

  def fill_in_signup(user)
    click_link 'All Users'
    click_link 'New User'
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button('Create User')
  end

  def fill_in_secret(secret)
    fill_in "Title", with: secret.title
    fill_in "Body", with: secret.body
    click_button('Create Secret')
  end

  def fill_in_edit
    click_link "Edit"
    fill_in "Title", with: "Edited Title"
    fill_in "Body", with: "Edited Body"
    click_button("Update Secret")
  end

end

module LoginMacros

  def create_user
    click_link "All Users"
    click_link "New User"
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Create User"
  end

  def create_alternative_user
    click_link "All Users"
    click_link "New User"
    fill_in "Name", with: "Name2"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Create User"
  end

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

  def create_invalid_user
    click_link "All Users"
    click_link "New User"
    click_button "Create User"
  end

  def create_secret
    click_link "New Secret"
    fill_in "Title", with: "secret title"
    fill_in "Body", with: "secret body"
    click_button "Create Secret"
  end

  def create_invalid_secret
    click_link "New Secret"
    click_button "Create Secret"
  end
end
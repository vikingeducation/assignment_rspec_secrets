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

  def make_secret(user)
    click_link "New Secret"
    fill_in "Title", with: "Testing Secret"
    fill_in "Body", with: "This is only a test."
    click_button "Create Secret"
  end
end

module LoginMacros
  # login macros for feature specs

  def sign_in(user)
    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end

  # login macros for request specs

  def login_as(user)
    post session_path, params: { email: user.email, password: user.password }
  end
end

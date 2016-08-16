module LoginMacros

  def sign_in(user)
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  def create_secret
    click_on "New Secret"
    fill_in "Title", with: "Title of Secret"
    fill_in "Body", with: "This is my secret"
    click_on "Create Secret"
  end

end

module LoginMacros

  def sign_in(user)
    visit root_path
    click_link("Login")
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password

    click_button("Log in")
  end

  def create_secret

    click_link("New Secret")
    fill_in "Title", with: "new secret"
    fill_in "Body", with: "Im a secret body"

    click_button("Create Secret")
  end

end
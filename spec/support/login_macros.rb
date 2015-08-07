module LoginMacros
  def sign_in(user)
    visit new_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: "foobar"
    click_button "Log in"
  end

  def sign_out
    visit root_path
    click_link "Log out"
  end
end
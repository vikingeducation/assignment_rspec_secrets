module LoginMacros
  def sign_in(user)
      click_link("Login")
      fill_in("Email", with: user.email )
      fill_in("Password", with: user.password )
      click_on("Log in")
  end
end
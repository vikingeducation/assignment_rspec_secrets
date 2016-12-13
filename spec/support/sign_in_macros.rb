module SigninMacros
  def sign_in( user, password = nil)
    visit root_path
    click_link 'Login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: (password || user.password)
    click_button "Log in"
  end
end

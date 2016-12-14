module LoginMacros
  def sign_in(user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def sign_out
    visit logout_path
  end
end

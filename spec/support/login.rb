module LoginMacros

  def sign_in(user)
    visit new_session_path
    fill_in 'Email', with: "qwerqwer"
    fill_in 'Password', with: "qwerqwer"
    click_button 'Log In'
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end

end

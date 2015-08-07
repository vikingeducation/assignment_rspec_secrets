module LoginMacros

  def sign_in(user)
    visit users_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password    
    expect{click_button "Log in"}.to change(User, :count).by(0)
  end

  def sing_out
    visit root_path
    click_link "Logout"
  end
end
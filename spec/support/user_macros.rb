module UserMacros
  def sign_in
    @u = create(:user)
    visit new_session_path
    fill_in 'email', with: @u.email
    fill_in 'password', with: @u.password
    click_button 'Log in'
  end
end

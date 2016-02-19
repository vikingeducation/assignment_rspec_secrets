module LoginMacros

  def create_user_deepa
      visit root_path
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      # click_link "All Secrets"
      # click_link "New Secret"
  end

  def sign_in_deepa
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'deepa@x.com'
    fill_in 'Password', with: 'foobar'
    click_button 'Log in'
  end


  def sign_in(user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end
end

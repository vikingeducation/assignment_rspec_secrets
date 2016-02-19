module LoginMacros

  def log_in(user)
    visit root_path
    click_link('Login')

    fill_in('Email', :with => user.email)
    fill_in('Password', :with => user.password)

    click_on('Log in')
  end

  def log_out
    click_on('Logout')
  end

end
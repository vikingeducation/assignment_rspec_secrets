module LoginMacros
  def login(user, password = 'foobar')
    visit root_path
    click_link('Login')
    fill_in('Email', with: user.email )
    fill_in('Password', with: password )
    click_button('Log in')
  end
end

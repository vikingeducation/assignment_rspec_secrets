module UserMacros

  def login(user)
    visit root_url
    click_link('Login')

    fill_in('Email', with: user.email)
    fill_in('Password', with: 'password')
    click_button("Log in")
  end

  def create_secret(user)
    user.secrets.create(title: generate_string(15), body: generate_string(130))
  end

end

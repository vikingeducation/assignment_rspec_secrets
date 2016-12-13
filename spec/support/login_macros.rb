module SecretMacros

  def sign_in(user)
    visit('session/new')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')
  end

  def create_secret(secret)
    click_link("New Secret")
    fill_in('Title', with: secret.title)
    fill_in('Body', with: secret.body)
    click_on('Create Secret')
  end

end
module SignupMacros
  def signup(options = {})
    visit users_path
    click_link('New User')
    fill_in('Name', with: options[:name])
    fill_in('Email', with: options[:email])
    fill_in('Password', with: options[:password])
    fill_in('Password confirmation', with: options[:confirmation])
    click_button('Create User')
  end
end

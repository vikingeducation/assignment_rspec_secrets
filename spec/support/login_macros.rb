module LoginMacros

  def sign_in(user)
    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def logout
    visit root_path
    click_link "Logout"
  end
  
end

RSpec.configure do |config|
  config.include LoginMacros
end

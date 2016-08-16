module UserMacros

  def sign_up
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "12345678")
  end

  def sign_in
    click_link("Login")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "12345678")
    click_button ("Log in")
  end

end
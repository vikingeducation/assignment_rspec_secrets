module Macros
  module User
    def sign_up( name="Foo", email="foo@bar.com", password="foobar", confirmation="foobar")
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
    end
  end
end

module Macros
  module User
    def sign_up( name="Foo", email="foo@bar.com", password="foobar", confirmation="foobar")
      visit(root_path)
      find_link('All Users').click
      find_link('New User').click
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
    end

    def log_out
      find_link("Logout").click
    end

    def log_in(email="foo@bar.com", password="foobar")
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end

    def fill_in_secret_form(title="Foo Title", body="Bar Body")
      fill_in "Title", with: title
      fill_in "Body", with: body
    end
  end
end

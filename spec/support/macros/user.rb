module Macros
  module User
    def sign_in(user)
      fill_in('Email', :with => user.email)
      fill_in('Password', :with => user.password)
      find('input[name="commit"]').click
    end

    def sign_out
      visit root_path
      click_link('Logout')
    end

    def signup(user, password, password_confirmation=nil)
      fill_in('Name', :with => user.name)
      fill_in('Email', :with => user.email)
      fill_in('Password', :with => password)
      fill_in('Password confirmation', :with => password_confirmation ? password_confirmation : password)
      find('input[name="commit"]').click
    end

    def click_destroy(user)
      find(%Q|a[href="/users/#{user.id}"][data-method="delete"]|).click
    end
  end
end
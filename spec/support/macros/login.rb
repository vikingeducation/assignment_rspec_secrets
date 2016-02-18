 module Macros

  module Login

    def sign_in
      visit new_session_path
      fill_in 'Email', with: 'foobar@example.com'
      fill_in 'Password', with: 'qwerqwer'
      click_button 'Log in'
    end

    def sign_out
      visit root_path
      click_link 'Logout'
    end

  end

 end

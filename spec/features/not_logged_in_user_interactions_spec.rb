require 'rails_helper'
include LoginMacros
include CreateSecretMacros
include EditUserMacros

RSpec.feature 'LoggedInUserInteractions' do

  feature "Not-signed-in User Paths" do

    let(:user){create(:user)}
    let(:users){create_list(:user, 3)}
    before do
      visit root_path
    end

  # Happy Path

    scenario 'As a not-signed-in user, I want to sign into my account' do
      sign_in(user)

      # verify logged in user
      expect(page).to have_content "Welcome, #{user.name}!"
    end

  # Sad Path

    scenario 'As a not-signed-in user wanting to sign-in, I may enter the wrong password' do
      click_link "Login"
      fill_in "Email", with: user.email
      fill_in "Password", with: "Not the users password"
      click_button "Log in"
      # verify it didn't log in user with incorrect password
      expect(page).not_to have_content "Welcome, #{user.name}!"
      # verify it takes you back to login page
      expect(page).to have_button "Log in"
    end

    scenario 'As a not-signed-in user wanting to sign-in, I may enter the wrong email' do
      click_link "Login"
      fill_in "Email", with: "Non existant user"
      fill_in "Password", with: user.password
      click_button "Log in"
      # verify it didn't log in
      expect(page).not_to have_content "Welcome, #{user.name}!"
      # verify it takes you back to log in
      expect(page).to have_button "Log in"
    end

  end

end

require 'rails_helper'

feature 'Secrets App' do

  let(:user) { create(:user) }

  context "when signed out" do

    scenario 'lists all secrets when navigating to root path' do
      five_secrets = []
      5.times do
        five_secrets << create(:secret, :sequence_of)
      end
      visit ('/')
      expect(page).to have_content five_secrets[0].title
      expect(page).to have_content five_secrets[4].title
    end

    scenario 'allows visitor to sign up' do
      visit ('users/new')
      fill_in('Name', :with => 'Bob Dobbs')
      fill_in('Email', :with => 'bob@subgenius.net')
      fill_in('Password', :with => 'password')
      fill_in('Password confirmation', :with => 'password')
      click_on("Create User")
      expect(page).to have_content "User was successfully created"
    end

    scenario 'when trying to sign up with blank name field, rerenders the sign up form with error messages' do
      visit ('users/new')
      fill_in('Name', :with => "")
      fill_in('Email', :with => 'bob@subgenius.net')
      fill_in('Password', :with => 'password')
      fill_in('Password confirmation', :with => 'password')
      click_on("Create User")
      expect(page).to have_content "Name can't be blank"
    end

    scenario 'when trying to sign up with blank email field, rerenders the sign up form with error messages' do
      visit ('users/new')
      fill_in('Name', :with => "Bob Dobbs")
      fill_in('Email', :with => "")
      fill_in('Password', :with => 'password')
      fill_in('Password confirmation', :with => 'password')
      click_on("Create User")
      expect(page).to have_content "Email can't be blank"
    end

    scenario 'when you bungle the password confirmation, rerenders the sign up form with errors' do
      visit ('users/new')
      fill_in('Name', :with => "Bob Dobbs")
      fill_in('Email', :with => "bob@subgenius.net")
      fill_in('Password', :with => 'password')
      fill_in('Password confirmation', :with => 'candlejack')
      click_on("Create User")
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'allows user to log in' do
      visit('session/new')
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_on("Log in")
      save_and_open_page
      expect(page).to have_content "Welcome, #{user.name}"
    end

  end

  context "when logged in" do

    scenario 'allows user to create a secret'
    scenario 'when trying to create a blank secret, rerenders the secret form with error messages'

    scenario 'allows user to edit his own secret'
    scenario 'does not allow user to edit another user\'s secret'

    scenario 'allows user to delete his own secret'
    scenario 'does not allow user to delete another user\'s secret'

  end

end
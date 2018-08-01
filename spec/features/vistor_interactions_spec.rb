require 'rails_helper'
include LoginMacros
include CreateSecretMacros
include EditUserMacros

RSpec.feature 'VisitorInteractions' do

  feature 'Visitor' do

    let(:user){create(:user)}
    let(:users){create_list(:user, 3)}
    before do
      visit root_path
    end

  # Happy Paths

    scenario 'As a visitor I want to view all secrets' do
      expect(page).to have_content "Listing secrets"
    end

    scenario 'As a visitor, I want to view all Users' do
      click_link "All Users"
      expect(page).to have_content "Listing users"
    end

    scenario 'As a visitor, I may want to view a specific secrect' do
      create_secret_for(user)
      click_link('Show')
      expect(page).to have_content "Title: #{user.secrets.first.title}"
    end

    scenario 'As a visitor I want to sign up as a User' do
      click_link "All Users"
      click_link "New User"
      fill_in "Name", with: "My Name"
      fill_in "Email", with: "myname@email.com"
      fill_in "Password", with: "1234567890"
      fill_in "Password confirmation", with: "1234567890"
      # verify user was create
      expect{ click_button "Create User" }.to change(User, :count).by(1)
      # verfiy rendered correct page after user created
      expect(page).to have_content "Name:"
    end

    # Sad Paths

      scenario 'As a visitor, I may try to see a users information' do
        more_users = users
        click_link "All Users"
        click_link "show1"
        # verify it doesn't show you user's show page
        expect(page).not_to have_content "Name: #{User.find(1).name}"
        # verify it does take you to log in page
        expect(page).to have_button "Log in"
      end

      scenario 'As a visitor, I may click to edit a users information' do
        more_users = user
        click_link "All Users"
        click_link "Edit"
        # verify it doesn't take you to edit page
        expect(page).not_to have_content "Editing user"
        # verify it does take you to log in page
        expect(page).to have_button "Log in"
      end

      scenario 'As a visitor, I may try to delete a users information' do
        more_users = user
        click_link "All Users"
        # verfiy it doesn't delete any records
        expect{click_link "Destroy"}.to change(User, :count).by(0)
        # verify it takes you to log in
        expect(page).to have_button "Log in"
      end

      scenario 'As a visitor, I may try to create a new secret' do
        click_link "New Secret"
        # verify takes you to log in not to new secret page
        expect(page).to have_button "Log in"
        expect(page).not_to have_content "New secret"
      end

  end

end

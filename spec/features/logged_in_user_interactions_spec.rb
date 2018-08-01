require 'rails_helper'
include LoginMacros
include CreateSecretMacros
include EditUserMacros

RSpec.feature 'LoggedInUserInteractions' do

  feature "Signed-in User" do

    let(:user){create(:user)}
    let(:users){create_list(:user, 3)}
    before do
      visit root_path
    end

  # Happy Path

    scenario 'As a signed-in User, I want to create a secret' do
      sign_in(user)
      click_link "New Secret"
      expect(page).to have_content "New secret"
      title = "This is  A title"
      body = "This is the titles body, see how it has more text?"
      fill_in "Title", with: title
      fill_in "Body", with: body
      # verify secret was created under user
      expect{ click_button "Create Secret" }.to change(user.secrets, :count).by(1)
      # verify rendered secret's show page
      expect(page).to have_content title
      # verfiy flash message worked properly
      expect(page).to have_content "Secret was successfully created."
    end

    scenario 'As a signed-in User, I want to edit a secrets' do
      sign_in(user)
      create_secret_for(user)
      click_link "Edit"
      expect(page).to have_content "Editing secret"
      new_title = "This is a new title"
      new_body = "And a new body to go with the new title"
      fill_in "Title", with: new_title
      fill_in "Body", with: new_body
      click_button "Update Secret"
      # verify secret updated and on correct show page
      expect(page).to have_content new_title
      expect(page).to have_content new_body
      # verify flash
      expect(page).to have_content "Secret was successfully updated."
    end

    scenario 'As a signed-in User, I want to delete one of my secrets' do
      sign_in(user)
      create_secret_for(user)
      secret_title = user.secrets.first.title
      # verify secret has been deleted
      expect{click_link "Destroy"}.to change(user.secrets, :count).by(-1)
      # verify rendered index page without secret
      expect(page).not_to have_content secret_title
      expect(page).to have_content "Listing secrets"
    end

    scenario 'As a signed-in user, I want to change my password' do
      sign_in(user)
      edit_profile(user)
      new_password = "password"
      fill_in "Password", with: new_password
      fill_in "Password confirmation", with: new_password
      click_button "Update User"
      #verify flash
      expect(page).to have_content "User was successfully updated."
      # verify password changed
      expect(user.password).to eq(new_password)
    end

    scenario 'As a signed-in user, I want to change my email address' do
      sign_in(user)
      edit_profile(user)
      new_email = "myemail@yahoo.com"
      fill_in "Email", with: new_email
      update_profile(user)
      # verify flash
      expect(page).to have_content "User was successfully updated."
      # verify correct page and updated information
      expect(page).to have_content "Email: #{new_email}"
    end

    scenario 'As a signed-in user, I want to change my name' do
      sign_in(user)
      edit_profile(user)
      new_name = "Bad Ass Name"
      fill_in "Name", with: new_name
      update_profile(user)
      # verify flash
      expect(page).to have_content "User was successfully updated."
      # verify updated and correct page
      expect(page).to have_content "Name: #{new_name}"
    end

    scenario 'As a signed-in user, I want to see my information' do
      sign_in(user)
      click_link "#{user.name}"
      expect(page).to have_content "Name: #{user.name}"
      expect(page).to have_content "Email: #{user.email}"
    end

    scenario "As a signed-in user, I want to see another user's information" do
      sign_in(user)
      new_user = create(:user)
      click_link "All Users"
      click_link("show2")
      # verify it's the new_user's page not current_user's
      expect(page).to have_content "Name: #{new_user.name}"
    end

  # Sad Paths

    scenario "As a signed-in user, I might try to delete a profile that isn't mine" do
      sign_in(user)
      more_users = users
      click_link "All Users"
      # verify user wasn't deleted
      expect{ click_link "destroy2" }.to change(User, :count).by(0)
      # verify it takes you back to secret index/root path
      expect(page).to have_content "Listing secrets"
    end

    scenario "As a signed-in user, I might try to edit a profile that isn't mine" do
      sign_in(user)
      more_users = users
      click_link "All Users"
      click_link "edit2"
      # verify you are not on edit page for another user
      expect(page).not_to have_content "Editing user"
      # verify it took you back to secret index/root path
      expect(page).to have_content "Listing secrets"
    end
  end
end

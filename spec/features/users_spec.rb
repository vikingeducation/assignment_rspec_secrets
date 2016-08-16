require 'rails_helper'

feature 'User' do

  let(:user){ create(:user, :with_attributes) }

  before do
    visit root_path
  end

  scenario "view all secrets" do
    expect(page).to have_content "Listing secrets"
  end

  scenario "add a new user" do
    click_link "All Users"
    click_link "New User"
    fill_in "Name", with: "Johnny"
    fill_in "Email", with: "abc@abc.com"
    fill_in "Password", with: "asdfasdf"
    fill_in "Password confirmation", with: "asdfasdf"

    expect{ click_button "Create User" }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, Johnny!"
    expect(page).to have_content "User was successfully created."
  end

  scenario "sign in to my account" do
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button('Log in')
    expect(page).to have_content "Welcome, Mike!"
    expect(page).to have_content "Logout"
  end

  scenario "create a secret" do
    sign_in(user)
    create_secret
    expect(page).to have_content "Secret was successfully created."
    expect(page).to have_content "Secret title"
  end

  scenario "edit one of previously created secrets" do
    sign_in(user)
    create_secret
    click_link "All Secrets"
    click_link "Edit"
    fill_in "Title", with: "New title"
    fill_in "Body", with: "new body"
    click_button "Update Secret"

    expect(page).to have_content "Secret was successfully updated."

    expect(page).to have_content "New title"
    expect(page).to have_content "new body"
  end

  scenario "delete one of previously created secrets" do
    sign_in(user)
    create_secret
    click_link "All Secrets"
    click_link "Destroy"

    expect(page).not_to have_content "Secret title"
    expect(page).not_to have_content "Secret body"
  end

  scenario "should not see author if not logged in and secrets have been made" do
    sign_in(user)
    create_secret
    sign_out
    visit root_path
    expect(page).to have_content "**hidden**"
  end

  scenario "should not show any secrets if none have been created" do
    visit root_path
    expect(page).not_to have_content "Show"
  end

  scenario "should not allow a user to delete a different users account" do
    sign_in(user)
    sign_out
    visit root_path
    click_link "All Users"
    click_link "Destroy"
    expect(page).to have_content "Password"
    expect(page).to have_content "Email"
  end

  scenario "shouldn't be able to log in after user is already logged in" do
    sign_in(user)
    visit root_path

    expect(page).to have_content "Logout"
    expect(page).not_to have_content "Login"
  end

  scenario "should not be able to logout when not logged in" do
    sign_in(user)
    sign_out

    visit root_path
    expect(page).not_to have_content "Logout"
    expect(page).to have_content "Login"
  end

  scenario "shouldn't be able to delete secrets when not signed in" do
    sign_in(user)
    sign_out

    visit root_path
    click_link "All Secrets"

    expect(page).not_to have_content "Destroy"
  end

  scenario "should not be able to create a new secret when not signed in" do
    sign_in(user)
    sign_out

    visit root_path
    click_link "All Secrets"
    click_link "New Secret"

    expect(page).to have_content "Password"
    expect(page).to have_content "Email"

    expect(page).not_to have_content "Title"
    expect(page).not_to have_content "Body"
  end

  scenario "shoud not be able to see users show page without signing in" do
    sign_in(user)
    sign_out

    visit root_path
    click_link "All Users"
    click_link "Show"

    expect(page).to have_content "Password"
    expect(page).to have_content "Email"
  end

  scenario "shoud not be able to see users edit page without signing in" do
    sign_in(user)
    sign_out

    visit root_path
    click_link "All Users"
    click_link "Edit"

    expect(page).to have_content "Password"
    expect(page).to have_content "Email"
  end
end

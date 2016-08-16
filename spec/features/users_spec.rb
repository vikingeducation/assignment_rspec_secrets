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




end
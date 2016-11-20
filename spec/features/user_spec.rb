require 'rails_helper'

describe "User" do
  before do
    visit root_url
  end

  scenario "create new account" do
    visit "users"
    click_on "New User"
    fill_in "Name", with: "Farruh"
    fill_in "Email", with: "ufarruh@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"
    click_on "Create User"
  end

  scenario "As a visitor, I want to view all secrets" do
    visit "secrets"
    assert_text "Listing secrets"
  end

  scenario "As a visitor, I want to sign up" do
    visit "users"
    click_on "New User"
    fill_in "Name", with: "Jack"
    fill_in "Email", with: "jack@example.com"
    fill_in "Password", with: "qwer1234"
    fill_in "Password confirmation", with: "qwer1234"
    click_button "Create User"
    assert_text "User was successfully created."
  end

  scenario "As a not-signed-in user, I want to sign in to my account" do
    new_user = create(:user)
    sign_in(new_user)
    find_link('Logout').visible?
  end
end

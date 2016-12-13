require 'rails_helper'

# `feature` is an alias for `describe`
feature 'User accounts' do
  before do
    # go to the home page
    visit root_path
  end

  # `scenario` is an alias for `it`
  scenario "New user" do

    visit new_user_path

    # fill in the form for a new user
    within "form#new_user" do
      first = "Foo"
      last = "Bar"
      fill_in "Name", with: "#{first} #{last}"
      fill_in "Email", with: "#{first}@#{last}.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
    end

    # submit the form and verify it created a user
    expect{ click_button "Create User" }.to change(User, :count).by(1)

    # verify that we've been logged in
    expect(page).to have_content "Name: Foo Bar"

    # verify the flash is working properly
    expect(page).to have_content "User was successfully created"

  end
  # ...and so on
end

feature "Authentication" do
  let(:user){create(:user)}

  context "Sign In" do
    scenario "with invalid credentials" do
      user.email = user.email + "asdf"
      sign_in(user)
      expect(page).to have_content "We couldn't sign you in"
    end

    scenario "with valid credentials" do
      sign_in(user)
      expect(page).to have_content "You've successfully signed in"
    end
  end
end

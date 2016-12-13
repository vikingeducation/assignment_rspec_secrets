require 'rails_helper'

describe "Visitor actions" do

  let ( :user ) { build(:user) }

  context "viewing secrets" do

    it "can view all secrets" do
      visit root_path
      expect(page).to have_content "Listing secrets"
    end

    it "cannot see other user's show pages" do
      user.save!
      visit users_path
      click_on "Show"
      expect(page).to have_current_path(new_session_path)
    end

  end

  context "signing up" do
    before do
      visit new_user_path
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
    end

    it "successfully adds a user for valid signups" do
      click_on "Create User"
      expect(page).to have_content("User was successfully created.")
      # expect(page).to have_current_path(user_path(user))
    end

    it "does not add a user for invalid signups"

  end

end

describe "Authentication" do

  context "with proper credentials" do

    it "allows you to sign in"

  end

  context "with improper credentials" do

    it "does not allow you to sign in"

  end

end

describe "Signed-in user actions" do

  context "working with users" do

    it "can edit themselves"

    it "cannot edit other users"

    it "can delete themselves"

    it "cannot delete other users"

  end

  context "working with secrets" do

    it "can create a secret"

    it "can edit their own secrets"

    it "cannot edit other user's secrets"

    it "can delete their own secrets"

    it "cannot delete other user's secrets"

  end

end

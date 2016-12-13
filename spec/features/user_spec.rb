require 'rails_helper'

feature 'Secrets#index' do
  let(:user){ create(:user) }
  let(:name){"NewFoo"}
  let(:email){"Newfoo@gmail.com"}
  before do
    visit root_path
  end

  context "not logged in" do
    it "shows the secrets" do
      expect(page).to have_content "Listing secrets"
    end
  end

  context "sign up new user" do
    before do
      click_link "All Users"
      click_link "New User"
      fill_in "Name", with: name
      fill_in "Email", with: email
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create User"
    end

    it "allows signup" do
      expect(page).to have_content("User was successfully created.")
      expect(page).to have_content(name)
      expect(page).to have_content(email)
    end

  end



  # context "with improper credentials" do
  #   before do
  #     user.email = user.email + "x"
  #     sign_in(user)
  #   end
  #
  #   scenario "does not allow sign in" do
  #     expect(page).to have_content "We couldn't sign you in"
  #   end
  # end
  #
  # context "with proper credentials" do
  #   before do
  #     sign_in(user)
  #   end
  #   scenario "successfully signs in an existing user" do
  #     # verify we're on the user's show page now
  #     expect(page).to have_content "You've successfully signed in"
  #   end
  #
  #   context "after signing out" do
  #     before do
  #       sign_out
  #     end
  #     scenario "signs out the user" do
  #       expect(page).to have_content "You've successfully signed out"
  #     end
  #   end
  # end
end

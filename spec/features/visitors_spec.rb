require 'rails_helper'

feature 'Visitor' do

  before do
    visit root_path
  end

  context "not yet sign up" do

    scenario "see all the secrets" do
      expect(page).to have_content("Listing secrets")
    end

    scenario "redirect to sign in if create a secret" do
      click_link("New Secret")

      expect(current_path).to eq(new_session_path)
    end
  end

  context "Sign up" do

    before do
      click_link("All Users")
      click_link("New User")
    end

    scenario "can signup with valid attributes" do

      fill_in "Name", with: "New_user"
      fill_in "Email", with: "new_user@email.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      expect{ click_button("Create User") }.to change(User, :count).by(1)

      expect(page).to have_content "successfully created"
    end

    scenario "cannot sign up with different password" do

      fill_in "Name", with: "new_user"
      fill_in "Email", with: "new_user@email.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "differentpassword"

      expect{ click_button("Create User") }.to change(User, :count).by(0)
    end
  end
end












require 'rails_helper'

feature "view secrets" do

  before do
    visit root_url
  end

  context "not logged in" do

    scenario "show all secrets" do
      expect(page).to have_content("Listing secrets")
    end

    scenario "make an account" do
      click_link("All Users")
      click_link("New User")

      fill_in("Name", with: "Qwerty" )
      fill_in("Email", with: "qwerty@asdf.com" )
      fill_in("Password", with: "asdfasdf" )
      fill_in("Password confirmation", with: "asdfasdf" )

      click_on("Create User")

      expect(page).to have_content("User was successfully created.")
    end

    scenario "logging in" do
      user = create(:user, email: "asdf@asdf.com",
                  password: "asdfasdf" )

      click_link("Login")
      fill_in("Email", with: user.email )
      fill_in("Password", with: user.password )
      click_on("Log in")

      expect(page).to have_content("Welcome, #{user.name}")
    end

  end

end

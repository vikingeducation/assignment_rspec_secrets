require 'rails_helper'

feature "view secrets" do
  let(:user){ create(:user) }
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

    scenario "logging in with valid data" do

      click_link("Login")
      fill_in("Email", with: user.email )
      fill_in("Password", with: user.password )
      click_on("Log in")

      expect(page).to have_content("Welcome, #{user.name}")
    end

    scenario "logging in with invalid data" do
      click_link("Login")
      fill_in("Email", with: "thisisnotanaccount@yahoo.com" )
      fill_in("Password", with: user.password )
      click_on("Log in")

      expect(page).to have_content("Login")
    end

    scenario "able to display secrets" do
        create(:secret)
        click_link("All Secrets")
        click_link("Show")
        expect(page).to have_content("Back")
    end
#
# secret_path(method: :delete)
# visit('/projects')
# visit(post_comments_path(post))

    scenario "can't destroy secrets" do
      secret = create(:secret)
      visit(secret_path(id: secret.id, method: :delete))
      click_link("All Secrets")
      expect(page).to have_content(secret.title)

    end

    scenario "can't edit secrets" do
      secret = create(:secret)
      visit(secret_path(id: secret.id, method: :patch))
      click_link("All Secrets")
      expect(page).to have_content(secret.title)
    end

  end








  context "logged in user" do
    scenario "can create a secret!" do
      sign_in(user)

      click_on("New Secret")
      fill_in("Title", with: "Wow such secret!" )
      fill_in("Body", with: "Much Juicy" )
      click_on("Create Secret")

      expect(page).to have_content("Secret was successfully created.")
    end

    scenario "can log out!" do
      sign_in(user)
      click_on("Logout")
      expect(page).to have_content("Login")
    end

    scenario "can edit secret!" do
      create(:secret, author: user)

      sign_in(user)

      click_link("Edit")
      fill_in("Title", with: "This is new" )
      fill_in("Body", with: "Very new" )
      click_on("Update Secret")

      expect(page).to have_content("Secret was successfully updated.")
    end

    scenario "can delete secret!" do
      create(:secret, author: user, title: "ABCDEFGH")
      sign_in(user)

      click_link("Destroy")

      expect(page).to_not have_content("ABCDEFGH")
    end

  end

end

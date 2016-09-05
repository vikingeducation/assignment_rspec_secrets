require 'rails_helper'

feature "Secrets" do 
  before do
    visit root_path
  end

  let(:author) { build(:author) }
  let(:secret) { build(:secret) }

  context "as a visitor" do

    scenario "view secrets" do
      click_link "All Secrets" 

      expect(page).to have_content "Listing secrets"
    end


    scenario "sign up" do
      click_link "All Users"
      click_link "New User"

      fill_in "Name", with: "Name"
      fill_in "Email", with: "email@email.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      expect{ click_button "Create User" }.to change(User, :count).by(1)


    end

    scenario "view users" do
      click_link "All Users"
      expect(page).to have_content "Listing users"
    end

    scenario "sign into an account" do
      click_link "Login"
      author.save!

      fill_in "Email", with: author.email
      fill_in "Password", with: author.password

      click_button "Log in"
      expect(page).to have_content("Welcome, #{author.name}!")
    end

  end

  context "as a signed in user" do
    before do 
      author.save
      click_link "Login"

      fill_in "Email", with: author.email
      fill_in "Password", with: author.password

      click_button "Log in"

    end


    scenario "be able to create a secret" do
      click_link "All Secrets"
      click_link "New Secret"

      fill_in "Title", with: secret.title
      fill_in "Body", with: secret.body

      expect{ click_button "Create Secret" }.to change(Secret, :count).by(1)

    end

    scenario "be able to edit one of my secrets" do
      click_link "New Secret"

      fill_in "Title", with: secret.title
      fill_in "Body", with: secret.body

      click_button "Create Secret"
      visit root_path
      
      click_link "Edit"
      fill_in "Title", with: "Edited Title"
      fill_in "Body", with: "Edited Body"
      click_button("Update Secret")

      expect(page).to have_content "Secret was successfully updated."
    end

    scenario "be able to delete one of my secrets" do
      click_link "New Secret"

      fill_in "Title", with: secret.title
      fill_in "Body", with: secret.body

      click_button "Create Secret"
      visit root_path

      click_link "Destroy"
      expect(page).to have_content "Listing secrets"
 
    end

  end
  




end
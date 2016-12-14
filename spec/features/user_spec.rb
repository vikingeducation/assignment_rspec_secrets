require 'rails_helper'

feature 'Secrets#index' do
  let(:user){ create(:user) }
  let(:name){"NewFoo"}
  let(:email){"Newfoo@gmail.com"}
  let(:updated_body){"updated_body"}
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
      create_user
    end

    it "allows signup" do
      expect(page).to have_content("User was successfully created.")
      expect(page).to have_content(name)
      expect(page).to have_content(email)
    end

  end

  context "as a not signed in user" do

    before do
      sign_in(user)
    end

    it "signs in valid user to my account" do
      expect(page).to have_content("Welcome, #{user.name}!")
    end

  end

  context "as a signed in user" do

    before do
      sign_in(user)
      create_secret
    end

    it "creates a secret when given valid inputs" do
      expect(page).to have_content("Secret was successfully created.")
    end

  end

  context "as a user who has created a secret" do

    before do
      sign_in(user)
      create_secret
      click_link "Edit"
      fill_in "Body", with: updated_body
      click_button "Update Secret"
    end

    it "successfully updates secret when edited" do

      expect(page).to have_content("Secret was successfully updated.")

      expect(page).to have_content(updated_body)
    end

  end

  context "as a user who has created a secret" do

    before do
      sign_in(user)
      create_secret
      click_link "All Secrets"
      click_link "Destroy"
    end

    it "does soemthing" do
      expect(html).to_not include("<td>")
    end

  end

  context "when creating a new user" do

    before do
      create_invalid_user
    end

    it "will show error messages when using an invalid input" do
      expect(page).to have_content("prohibited this user from being saved:")
    end

    it "will style fields as fields with errors" do
      expect(page).to have_css("div.field_with_errors")
    end

  end

  context "while logged in" do

    before do
      sign_in(user)
    end

    it "will not allow you to create a new user" do
      # unwanted behavior
      create_user
      expect(page).to_not have_content("User was successfully created.")
    end

    it "will allow you to attempt to delete another user" do
      create_alternative_user
      click_link "All Users"
      expect(page).to have_content("Destroy", count: 2)
    end

    it "will allow you to attempt to edit another user" do
      create_alternative_user
      click_link "All Users"
      expect(page).to have_content("Edit", count: 2)
    end

  end

  context "when creating a new secret" do

    before do
      sign_in(user)
      create_invalid_secret
    end

    it "will show error messages when using an invalid input" do
      expect(page).to have_content("prohibited this secret from being saved:")
    end

    it "will style fields as fields with errors" do
      expect(page).to have_css("div.field_with_errors")
    end

  end

  context "when editing a secret" do
    before do
      sign_in(user)
      create_secret
      click_link "All Secrets"
      click_link "Edit"
      fill_in "Title", with: ""
      fill_in "Body", with: ""
      click_button "Update Secret"
    end

    it "will show error messages when using an invalid input" do
      expect(page).to have_content("prohibited this secret from being saved:")
    end

    it "will style fields as fields with errors" do
      expect(page).to have_css("div.field_with_errors")
    end

  end

end

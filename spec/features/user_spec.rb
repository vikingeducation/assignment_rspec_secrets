require 'rails_helper'

feature 'User sign up' do
  let!(:user) { create(:user) }


  before do 
    visit new_user_path
  end

  specify "the user can click on the sign up link to get to a sign up form" do 

    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    expect{ click_button "Create User" }.to change(User, :count).by(1)

    expect(page).to have_content "User was successfully created."
  end

  specify "an incomplete form re-renders the page" do 

    name = "Foo"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    expect{ click_button "Create User" }.to change(User, :count).by(0)

    expect(page).to have_css(".field_with_errors")
  end

end

feature 'User sign in' do 

  let(:user){ create(:user) }

  # Happy path.
  context "when the user inputs valid login credentials" do
    before do
      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end

    specify "the user can sign in from the sign in path" do 
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    specify "a signed in user can create a new secret" do
      click_on "New Secret"

      expect(page).to have_content("New secret")
    end

    specify "a signed in user can edit an exisitng secret" do
      user.secrets.create(attributes_for(:secret))

      click_on "All Secrets"
      click_on "Edit"
      

      expect(page).to have_content("Editing secret")
    end

    specify "a signed in user can delete an exisitng secret" do
      user.secrets.create(attributes_for(:secret))

      click_on "All Secrets"
      

      expect{ click_on "Destroy" }.to change(Secret, :count).by(-1)
    end

    specify "a signed in user can see the author of a secret" do
      other_user = create(:user)
      user.secrets.create(attributes_for(:secret))
      other_user.secrets.create(attributes_for(:secret))
      click_on "All Secrets"
      save_and_open_page
      
      expect(page).to have_content(other_user.name)
    end

  end

  # Sad path.
  context "when the user does not input valid login credentials" do
    before do
      visit new_session_path
      fill_in "Email", with: "dasda"
      fill_in "Password", with: "some password"
    end

    specify "the user can't sign in from the sign in path" do 
      click_button "Log in"
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    end

    specify "the user can't create a new secret" do 
      visit new_secret_path
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    end

    specify "the user can't edit an existing secret" do
      user.secrets.create(attributes_for(:secret))

      visit edit_secret_path(user.secrets.first)
      
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    end

    specify "the user can't delete an exisitng secret" do
      user.secrets.create(attributes_for(:secret))

      click_on "All Secrets"

      expect(page).to_not have_content("Destroy")
    end

  end

end
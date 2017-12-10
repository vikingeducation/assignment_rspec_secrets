require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.not_to raise_error
  end

  it "user has an email address" do
    expect(user.email).not_to eq("")
  end

  it "user name has the right number of characters" do
    expect(user.email).not_to eq("")
  end

  it "user name has to be the correct length" do
    expect(user.name.length).to be_between(3,20)
  end

  describe "attributes" do
    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end
  end

  describe "User Associations" do
     it "responds to the posts association" do
      expect(user).to respond_to(:secrets)
    end
  end
end


# Feature Intergation testing

feature 'Visitor' do
  before do
    # go to the home page
    visit root_path
  end


  scenario "see all the secrets" do
    visit root_path
    expect(page).to have_content "Listing secrets"
  end
   # `scenario` is an alias for `it`
  scenario "As a visitor, I want to sign up" do

    # go to the signup page
    click_link "All Users"

    # go to the signup page
    click_link "New User"

    name = "foo"
    fill_in "Name", with: name
    fill_in "Email", with: "#{name}@bar.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"

     # submit the form and verify it created a user
    expect{ click_button "Create User" }.to change(User, :count).by(1)

    # verify that we've been redirected to that user's page
    expect(page).to have_content "Welcome, #{name}!"

    # verify the flash is working properly
    expect(page).to have_content "User was successfully created."    
  end


  scenario "As a visitor, does not correctly sign up" do
    click_link "All Users"
    click_link "New User"
    name = "foo"
    fill_in "Name", with: name
    fill_in "Email", with: "#{name}@bar.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar2"

    expect{ click_button "Create User" }.to change(User, :count).by(0)
  end
end

feature 'User accounts' do
  let(:user){create(:user)}
  before do
    visit root_path
  end

  scenario "As a not-signed-in user, I want to sign in to my account" do
    click_link "Login"
    name = user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Welcome, #{name}"
  end

  scenario "As a not-signed-in user, does not sign into account with no password" do
    click_link "Login"
    name = user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: ""
    click_button "Log in"

    expect(has_button?("Log in")).to be true
  end

  scenario "As a not-signed-in user, does not sign into account with incorrect password" do
    click_link "Login"
    name = user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: "Wrong password"
    click_button "Log in"

    expect(has_button?("Log in")).to be true
  end
end

feature "Signed in User" do
    let(:user){create(:user)}
    before do
       sign_in(user)
    end

    scenario "As a signed-in user, I want to be able to create a secret" do
      click_link "New Secret"
      fill_in "Title", with: "Test secret"
      fill_in "Body", with: "Test body"

      expect{ click_button "Create Secret" }.to change(Secret, :count).by(1)
      expect(page).to have_content "Title:"
      expect(page).to have_content "Secret was successfully created."
    end

    scenario "As a signed-in user, I can't create a secret if the title is blank" do
      click_link "New Secret"
      fill_in "Title", with: ""
      fill_in "Body", with: "Test body"

      expect{ click_button "Create Secret" }.to change(Secret, :count).by(0)
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "errors prohibited this secret from being saved"
    end

    scenario "As a signed-in user, I want to be able to edit one of my secrets" do
      create_secret(user)
      click_link "Edit"
      fill_in "Title", with: "Testing update works"
      fill_in "Body", with: "Testing updating body works"
      click_button "Update Secret"

      expect(has_link?("Edit")).to be true
      expect(page).to have_content "Secret was successfully updated."
      expect(current_path).to eq(secret_path(1))
    end

    scenario "As a signed-in user, I can't save an updated secret if the title only has 1 character" do
      create_secret(user)
      click_link "Edit"
      fill_in "Title", with: "1"
      fill_in "Body", with: "Testing updating body works"
      click_button "Update Secret"
      expect(page).to have_content "Title is too short"
    end

    scenario "As a signed-in user, I can't save an updated secret if the title is too long" do
      create_secret(user)
      click_link "Edit"
      fill_in "Title", with: "Title is too long by xlxlxlxlxlxlxlxlxlxxlxlxlxlxlxlxlxlxlxlxlxlx"
      fill_in "Body", with: "Testing updating body works"
      click_button "Update Secret"
      expect(page).to have_content "Title is too long"
    end

    scenario "As a signed-in user, I can delete a secret" do
      create_secret(user)
      click_link "Back"
      expect{  click_link "Destroy" }.to change(Secret, :count).by(-1)
    end

    scenario "As a signed-in user, I cannot delete a secret if I have not created any" do
     expect(page).to have_no_content("Destroy")
   end

   scenario "As a signed-in user, I can log out" do
     click_link "Logout"
     expect(has_link?("Logout")).to be false
   end

   scenario "As a signed-in user, I can view a list of all users" do
     click_link "All Users"
     expect(page).to have_content("Listing users")
     expect(has_link?("New User")).to be true
   end
  end
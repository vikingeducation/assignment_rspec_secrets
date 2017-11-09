require 'rails_helper'

describe User do
  let(:user){ build(:user) }
  name_minimum = 3
  name_maximum = 20
  password_minimum = 6
  password_maximum = 16

  it {should have_secure_password}

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }

  it { should validate_length_of(:name).
    is_at_least(name_minimum).is_at_most(name_maximum)}

  it { should validate_uniqueness_of(:email)}

  it { should validate_presence_of(:password)}

  it { should validate_length_of(:password).
    is_at_least(password_minimum).is_at_most(password_maximum)}

  it "responds to the secrets association" do
        expect(user).to respond_to(:secrets)
      end
end

feature 'Visitor' do
  scenario "see all secrets" do
    visit root_path
  end
  before do
    visit root_path
  end
  scenario "add a new user" do
    click_link "All Users"
    click_link "New User"
    name = "Jerome"
    fill_in "Name", with: name
    fill_in "Email", with: "jerome@steelers.com"
    fill_in "Password", with: "jerome36"
    fill_in "Password confirmation", with: "jerome36"
    expect{ click_button "Create User" }.to change(User, :count).by(1)
  end
  scenario "does not add a new user with short name" do
    click_link "All Users"
    click_link "New User"
    name = "JB"
    fill_in "Name", with: name
    fill_in "Email", with: "jerome@steelers.com"
    fill_in "Password", with: "jerome36"
    fill_in "Password confirmation", with: "jerome36"
    expect{ click_button "Create User" }.to change(User, :count).by(0)
  end
  scenario "does not add a new user with duplicate email" do
    click_link "All Users"
    click_link "New User"
    name = "JB"
    fill_in "Name", with: name
    fill_in "Email", with: "carl@pens.com"
    fill_in "Password", with: "jerome36"
    fill_in "Password confirmation", with: "jerome36"
    expect{ click_button "Create User" }.to change(User, :count).by(0)
  end
end

feature "Not Signed In User" do
  before do
    visit root_path
  end
  scenario "sign into account" do
    click_link "Login"
    fill_in "Email", with: "carl@pens.com"
    fill_in "Password", with: "carl62"
    click_button 'Log in'
    expect(current_path).to eq(session_path)
  end
  scenario " does not sign into account with invalid password" do
    click_link "Login"
    fill_in "Email", with: "carl@pens.com"
    fill_in "Password", with: "carl87"
    click_button 'Log in'
    expect(current_path).to eq(session_path)
  end
  scenario " does not sign into account with no email" do
    click_link "Login"
    fill_in "Email", with: ""
    fill_in "Password", with: "carl62"
    click_button 'Log in'
    expect(current_path).to eq(session_path)
  end


end

feature "signed in User" do
  let(:user){create(:user)}
  before do
    sign_in(user)
  end
  scenario "create a secret" do
    click_link "New Secret"
    fill_in "Title", with: "Testing Secret"
    fill_in "Body", with: "This is only a test."
    expect{ click_button "Create Secret" }.to change(Secret, :count).by(1)
  end
  scenario "does not create a secret with long title" do
    click_link "New Secret"
    fill_in "Title", with: "Testing Secret a really really really long title"
    fill_in "Body", with: "This is only a test."
    expect{ click_button "Create Secret" }.to change(Secret, :count).by(0)
  end
  scenario "does not create a secret with short body" do
    click_link "New Secret"
    fill_in "Title", with: "Testing Secret"
    fill_in "Body", with: "no"
    expect{ click_button "Create Secret" }.to change(Secret, :count).by(0)
  end

  scenario "edit a secret" do
    make_secret(user)
    click_link "Edit"
    fill_in "Title", with: "Testing Secret"
    fill_in "Body", with: "This is only a test."
    click_button "Update Secret"
    expect(current_path).to eq(secret_path(1))
  end
  scenario "does not edit a secret with long title" do
    make_secret(user)
    click_link "Edit"
    fill_in "Title", with: "Testing Secret a really really really long title"
    fill_in "Body", with: "This is only a test."
    click_button "Update Secret"
    expect(current_path).to eq(secret_path(1))
  end
  scenario "does not edit a secret with missing body" do
    make_secret(user)
    click_link "Edit"
    fill_in "Title", with: "Testing Secret"
    fill_in "Body", with: ""
    click_button "Update Secret"
    expect(current_path).to eq(secret_path(1))
  end

  scenario "delete a secret" do
    make_secret(user)
    click_link "Back"
    click_link "Destroy"
    expect(current_path).to eq(secrets_path)
  end

  scenario "cannot delete secret if user has not created one" do
    expect(page).to have_no_content("Destroy")
  end
end

require 'rails_helper'

=begin
As a visitor, I want to view all secrets
As a visitor, I want to sign up
As a not-signed-in user, I want to sign in to my account
As a signed-in user, I want to be able to create a secret
As a signed-in user, I want to be able to edit one of my secrets
As a signed-in user, I want to be able to delete one of my secrets
=end

feature "Guest interactions" do
  let(:secret){ create(:secret) }
  before do
    secret
    visit root_path
  end

  scenario "view all secrets" do
    expect(page).to have_content "#{secret.title} #{secret.body}"
  end

  scenario "user sign up" do

    # Go to All Users
    click_link "All Users"

    # Go to new user
    click_link "New User"

    # Fill in form for new user
    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    # submit the form and verify it created a user
    expect{ click_button "Create User" }.to change(User, :count).by(1)

    # verify it redirects upon successful creation
    expect(page).to have_content "#{name}"

    expect(page).to have_content "User was successfully created"

  end

  let!(:user){ create(:user) }

  scenario "User sign in" do

    # Click login
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    # submit the form and verify it created a user
    click_button "Log in"

    # verify it redirects upon successful creation
    expect(page).to have_content "#{user.name}"

  end
end

feature "Signed in user interactions" do
  let!(:user){ create(:user) }
  before do
    visit root_path
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    # submit the form and verify it created a user
    click_button "Log in"
  end

  scenario "sign in user can create, edit, and delete secrets" do

    # Create Secret
    click_link "New Secret"

    secret_title = "foobarfoobarfoobar"
    secret_body = "foo foo foo bar bar bar"

    fill_in "Title", with: secret_title
    fill_in "Body", with: secret_body

    expect{ click_button "Create Secret" }. to change(Secret, :count).by(1)

    expect(page).to have_content "Title: #{secret_title}"
    expect(page).to have_content "Body: #{secret_body}"
    expect(page).to have_content "Secret was successfully created"

    # Edit secret
    click_link "Edit"

    secret_title2 = "barfoobarfoobarfoo"
    secret_body2 = "bar bar bar foo foo foo"

    fill_in "Title", with: secret_title2
    fill_in "Body", with: secret_body2

    click_button "Update Secret"

    expect(page).to have_content "Title: #{secret_title2}"
    expect(page).to have_content "Body: #{secret_body2}"
    expect(page).to have_content "Secret was successfully updated"

    click_link "All Secrets"

    expect(page).to have_content "#{secret_title2} #{secret_body2}"

    expect{ click_link "Destroy" }.to change(Secret, :count).by(-1)

    expect(page).not_to have_content "#{secret_title2} #{secret_body2}"


  end

end

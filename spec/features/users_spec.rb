# spec/features/users_spec.rb
require 'rails_helper'

feature 'As a visitor,' do
  before do
    visit root_path
  end

  scenario 'I want to view all users' do
    click_link 'All Users'

    expect(page).to have_content("Listing users")
  end

  scenario 'I want to view all secrets' do
    click_link 'All Secrets'

    expect(page).to have_content("Listing secrets")
  end

  scenario 'I want to sign up' do
    click_link 'All Users'
    click_link 'New User'

    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarbar"
    fill_in "Password confirmation", with: "foobarbar"

    # test if new User was created
    expect { click_button "Create User" }.to change(User, :count).by(1)

    # test if we're on the User show page
    expect(page).to have_content("Welcome, #{name}!")
    expect(page).to have_content("Name: #{name}")
    expect(page).to have_content("Email: foo@bar.com")

    # test if flash message is displayed
    expect(page).to have_content("User was successfully created.")
  end

  scenario "I am logged in after signing up" do
    click_link 'All Users'
    click_link 'New User'

    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarbar"
    fill_in "Password confirmation", with: "foobarbar"
    click_button "Create User"

    expect(find_link("Logout").visible?).to be true
  end
end

feature 'As a not signed-in user,' do
  before do
    visit root_path
  end

  scenario 'I want to sign in to my account' do
    user = create(:user)

    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # test if we're on the Secrets index page after signing in
    expect(page).to have_content("Welcome, #{user.name}!")
    expect(page).to have_content("Listing secrets")
  end

  scenario 'I should not be able to edit a secret' do
    # create a Secret
    secret = create(:secret)

    # check if there are Edit links on the root path
    expect(has_link?("Edit")).to be false

    # check if there are Edit links on the Secrets index page
    click_link("All Secrets")
    expect(has_link?("Edit")).to be false

    #  go to the Show page of the Secret we created, and check if there's an Edit link
    visit secret_path(secret)
    expect(has_link?("Edit")).to be false
  end

  scenario 'I should not be able to delete a secret' do
    # create a Secret
    secret = create(:secret)

    # check if there are Destroy links on the root path
    expect(has_link?("Destroy")).to be false

    # check if there are Destroy links on the Secrets index page
    click_link("All Secrets")
    expect(has_link?("Destroy")).to be false

    #  go to the Show page of the Secret we created, and check if there's a Destroy link
    visit secret_path(secret)
    expect(has_link?("Destroy")).to be false
  end

  scenario 'I should not be able to view details of a specific user' do
    user = create(:user)

    visit user_path(user)

    expect(page).not_to have_content("Name:")
    expect(page).not_to have_content("Email:")
  end
end

feature 'As a signed-in user,' do
  # using eager let to ensure Users and Secrets are created before specs run
  let!(:secret) { create(:secret) }
  let!(:author) { secret.author }
  let!(:another_secret) { create(:secret) }
  let!(:another_author) { another_secret.author }

  before { sign_in(author) }

  scenario 'the authors of all secrets should be visible to me' do
    expect(page).to have_content(author.name)
    expect(page).to have_content(another_author.name)
  end

  scenario 'the author of an individual secret should be visible to me' do
    visit secret_path(secret)
    expect(page).to have_content(secret.author.name)

    visit secret_path(another_secret)
    expect(page).to have_content(another_secret.author.name)
  end

  scenario 'I want to be able to create a secret' do
    num_secrets = author.secrets.count

    click_link "New Secret"

    fill_in "Title", with: "My new secret"
    fill_in "Body", with: "My very, very special new secret"

    expect { click_button "Create Secret" }.to change(Secret, :count).by(1)
    expect(author.secrets.count).to eq(num_secrets + 1)
  end

  scenario 'I want to be able to edit one of my secrets' do
    click_link "Edit"

    new_title = "My edited secret"
    new_body = "I've changed the contents of my secret"

    fill_in "Title", with: new_title
    fill_in "Body", with: new_body
    click_button "Update Secret"

    expect(page).to have_content("Secret was successfully updated.")
    expect(page).to have_content("Title: #{new_title}")
    expect(page).to have_content("Body: #{new_body}")
  end

  # can't do this with the default RackTest driver
  scenario 'I want to be able to delete one of my secrets'

  scenario 'I want to view details of a specific user' do
    click_link "All Users"
    visit user_path(another_author)

    expect(page).to have_content("Name:")
    expect(page).to have_content("Email:")
  end

  scenario "I should not be able to edit another User's secrets" do
    visit secret_path(another_secret)

    expect(has_link?("Edit")).to be false
  end

  scenario "I should not be able to delete another User's secrets" do
    visit secret_path(another_secret)

    expect(has_link?("Destroy")).to be false
  end

  scenario 'I should be able to log out' do
    click_link "Logout"

    expect(has_link?("Logout")).to be false
    expect(page).not_to have_content("Welcome, #{author.name}!")
  end
end

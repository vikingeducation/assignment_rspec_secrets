require 'rails_helper'
include LoginMacros
include CreateSecretMacros
include EditUserMacros

feature 'User Accounts' do
  let(:user){create(:user)}
  let(:users){create_list(:user, 3)}
  before do
    visit root_path
  end
# main happy paths
  scenario 'As a visitor I want to view all secrets' do
    expect(page).to have_content "Listing secrets"
  end

  scenario 'As a visitor, I want to view all Users' do
    click_link "All Users"
    expect(page).to have_content "Listing users"
  end

  scenario 'As a visitor, I may want to view a specific secrect' do
    create_secret_for(user)
    click_link('Show')
    expect(page).to have_content "Title: #{user.secrets.first.title}"
  end

  scenario 'As a visitor I want to sign up as a User' do
    click_link "All Users"
    click_link "New User"
    fill_in "Name", with: "My Name"
    fill_in "Email", with: "myname@email.com"
    fill_in "Password", with: "1234567890"
    fill_in "Password confirmation", with: "1234567890"
    # verify user was create
    expect{ click_button "Create User" }.to change(User, :count).by(1)
    # verfiy rendered correct page after user created
    expect(page).to have_content "Name:"
  end

  scenario 'As a not-signed-in user, I want to sign into my account' do
    sign_in(user)

    # verify logged in user
    expect(page).to have_content "Welcome, #{user.name}!"
  end

  scenario 'As a signed-in User, I want to create a secret' do
    sign_in(user)
    click_link "New Secret"
    expect(page).to have_content "New secret"
    title = "This is  A title"
    body = "This is the titles body, see how it has more text?"
    fill_in "Title", with: title
    fill_in "Body", with: body
    # verify secret was created under user
    expect{ click_button "Create Secret" }.to change(user.secrets, :count).by(1)
    # verify rendered secret's show page
    expect(page).to have_content title
    # verfiy flash message worked properly
    expect(page).to have_content "Secret was successfully created."
  end

  scenario 'As a signed-in User, I want to edit a secrets' do
    sign_in(user)
    create_secret_for(user)
    click_link "Edit"
    expect(page).to have_content "Editing secret"
    new_title = "This is a new title"
    new_body = "And a new body to go with the new title"
    fill_in "Title", with: new_title
    fill_in "Body", with: new_body
    click_button "Update Secret"
    # verify secret updated and on correct show page
    expect(page).to have_content new_title
    expect(page).to have_content new_body
    # verify flash
    expect(page).to have_content "Secret was successfully updated."
  end

  scenario 'As a signed-in User, I want to delete one of my secrets' do
    sign_in(user)
    create_secret_for(user)
    secret_title = user.secrets.first.title
    # verify secret has been deleted
    expect{click_link "Destroy"}.to change(user.secrets, :count).by(-1)
    # verify rendered index page without secret
    expect(page).not_to have_content secret_title
    expect(page).to have_content "Listing secrets"
  end

  scenario 'As a signed-in user, I want to change my password' do
    sign_in(user)
    edit_profile(user)
    new_password = "password"
    fill_in "Password", with: new_password
    fill_in "Password confirmation", with: new_password
    click_button "Update User"
    #verify flash
    expect(page).to have_content "User was successfully updated."
    # verify password changed
    expect(user.password).to eq(new_password)
  end

  scenario 'As a signed-in user, I want to change my email address' do
    sign_in(user)
    edit_profile(user)
    new_email = "myemail@yahoo.com"
    fill_in "Email", with: new_email
    update_profile(user)
    # verify flash
    expect(page).to have_content "User was successfully updated."
    # verify correct page and updated information
    expect(page).to have_content "Email: #{new_email}"
  end

  scenario 'As a signed-in user, I want to change my name' do
    sign_in(user)
    edit_profile(user)
    new_name = "Bad Ass Name"
    fill_in "Name", with: new_name
    update_profile(user)
    # verify flash
    expect(page).to have_content "User was successfully updated."
    # verify updated and correct page
    expect(page).to have_content "Name: #{new_name}"
  end

  scenario 'As a signed-in user, I want to see my information' do
    sign_in(user)
    click_link "#{user.name}"
    expect(page).to have_content "Name: #{user.name}"
    expect(page).to have_content "Email: #{user.email}"
  end

  scenario "As a signed-in user, I want to see another user's information" do
    sign_in(user)
    new_user = create(:user)
    click_link "All Users"
    click_link("show2")
    # verify it's the new_user's page not current_user's
    expect(page).to have_content "Name: #{new_user.name}"
  end

  # main user Sad Paths

  scenario 'As a visitor, I may try to see a users information' do
    more_users = users
    click_link "All Users"
    click_link "show1"
    # verify it doesn't show you user's show page
    expect(page).not_to have_content "Name: #{User.find(1).name}"
    # verify it does take you to log in page
    expect(page).to have_button "Log in"
  end

  scenario 'As a visitor, I may click to edit a users information' do
    more_users = user
    click_link "All Users"
    click_link "Edit"
    # verify it doesn't take you to edit page
    expect(page).not_to have_content "Editing user"
    # verify it does take you to log in page
    expect(page).to have_button "Log in"
  end

  scenario 'As a visitor, I may try to delete a users information' do
    more_users = user
    click_link "All Users"
    # verfiy it doesn't delete any records
    expect{click_link "Destroy"}.to change(User, :count).by(0)
    # verify it takes you to log in
    expect(page).to have_button "Log in"
  end

  scenario 'As a visitor, I may try to create a new secret' do
    click_link "New Secret"
    # verify takes you to log in not to new secret page
    expect(page).to have_button "Log in"
    expect(page).not_to have_content "New secret"
  end

  scenario 'As a not-signed-in user wanting to sign-in, I may enter the wrong password' do
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Not the users password"
    click_button "Log in"
    # verify it didn't log in user with incorrect password
    expect(page).not_to have_content "Welcome, #{user.name}!"
    # verify it takes you back to login page
    expect(page).to have_button "Log in"
  end

  scenario 'As a not-signed-in user wanting to sign-in, I may enter the wrong email' do
    click_link "Login"
    fill_in "Email", with: "Non existant user"
    fill_in "Password", with: user.password
    click_button "Log in"
    # verify it didn't log in
    expect(page).not_to have_content "Welcome, #{user.name}!"
    # verify it takes you back to log in
    expect(page).to have_button "Log in"
  end

  scenario "As a signed-in user, I might try to delete a profile that isn't mine" do
    sign_in(user)
    more_users = users
    click_link "All Users"
    # verify user wasn't deleted
    expect{ click_link "destroy2" }.to change(User, :count).by(0)
    # verify it takes you back to secret index/root path
    expect(page).to have_content "Listing secrets"
  end

  scenario "As a signed-in user, I might try to edit a profile that isn't mine" do
    sign_in(user)
    more_users = users
    click_link "All Users"
    click_link "edit2"
    # verify you are not on edit page for another user
    expect(page).not_to have_content "Editing user"
    # verify it took you back to secret index/root path 
    expect(page).to have_content "Listing secrets"
  end



end
# main user Happy Paths
# As a visitor, I want to view all secrets
# As a visitor, I may want to view a specific secrect
# As a visitor, I want to see all Users
# As a visitor, I want to sign up
# As a not-signed-in user, I want to sign in to my account
# As a signed-in user, I want to be able to create a secret
# As a signed-in user, I want to be able to edit one of my secrets
# As a signed-in user, I want to be able to delete one of my secrets

# As a signed-in user, I want to change my password
# As a signed-in user, I want to change my email address
# As a signed-in user, I want to change my name
# As a signed-in user, I want to see my information
# As a signed-in user, I want to see another user's information

# main user Sad Paths
# As a visitor, I may click on show a user's information
# As a visitor, I may click to edit a user's information
# As a visitor, I may click to delete a user's information
# As a visitor, I may try to create a new secret
# As a not-signed-in user wanting to sign-in, I accidently enter the wrong password
# As a not-signed-in user wanting to sign-in, I accidently enter the wrong username

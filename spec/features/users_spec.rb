require 'rails_helper'

feature 'Visitor functionality' do

  before do
    create(:secret)
    visit root_path
  end


  # As a visitor, I want to view all secrets
  scenario 'visitor view all secrets' do
    expect(page).to have_content "Listing secrets"
  end


  # As a visitor, I want to be able to navigate to the sign-up page
  scenario 'navigate to sign-up page' do
    click_link "All Users"
    click_link "New User"
    expect(page).to have_content "Password confirmation"
  end


  # As a visitor, I should not see secret author names
  scenario 'author names hidden from visitors' do
    expect(page).to have_content "**hidden**"
  end


  # Visitor should not see edit/delete secret links
  scenario 'edit/delete links should be missing' do
    expect(page).not_to have_content "Edit"
    expect(page).not_to have_content "Delete"
  end


  # Visitor going to user show should end up on Login
  scenario 'should be redirected when trying to show a user' do
    visit user_path(User.first)
    expect(current_path).to eq(new_session_path)
  end


end


feature 'Sign up flow' do

  before do
    visit root_path
    click_link "All Users"
    click_link "New User"
  end


  # As a visitor, I want to sign up
  scenario 'visitor sign up with valid information' do

    name = "Foobaz"
    email = "#{name.downcase}@example.com"
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: name.downcase
    fill_in "Password confirmation", with: name.downcase

    click_button "Create User"

    # result is show page for the new user
    expect(current_path).to eq(user_path(User.last))

    # result page shows new user name
    expect(page).to have_content name

    # result page shows new user email
    expect(page).to have_content email
  end


  # Visitor sign-up with bad info should be shown errors
  scenario 'visitor sign up with invalid information' do

    name = "Foobaz"
    email = "#{name.downcase}@example.com"
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: name.downcase
    fill_in "Password confirmation", with: "bad_info"

    click_button "Create User"

    # result page should re-render form
    expect(page).to have_content "New user"

    # result page should show errors
    expect(page).to have_content "error prohibited this user from being saved"
  end


end


feature 'User accounts' do

  # As a not-signed-in user, I want to sign in to my account
  # As a signed-in user, I want to be able to create a secret
  # As a signed-in user, I want to be able to edit one of my secrets
  # As a signed-in user, I want to be able to delete one of my secrets

end
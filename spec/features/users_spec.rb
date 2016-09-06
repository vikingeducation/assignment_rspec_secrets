require 'rails_helper'

feature "User account" do
  before do
    visit root_path
  end

  scenario "log in a user" do
    my_user = create(:user)
    sign_in(my_user)
    expect(page).to have_content "You've successfully signed in"
    expect(page).to have_content "Listing secrets"
  end

  scenario "no author name shown without log in" do
    secrets = create(:secret)
    visit root_path
    expect(page).to have_content "**hidden**"
  end

  scenario "show author name with log in" do
    my_user = create(:user)
    secret = create(:secret)
    sign_in(my_user)
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "this is title"
    expect(page).not_to have_content "**hidden**"
  end

  scenario "show edit link with log in user for his post" do
    my_user = create(:user)
    secret = create(:secret, author: my_user)
    sign_in(my_user)
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "Edit"
  end

  scenario "do not show edit, destroy button for post does not belongs to the user" do
    my_user = create(:user)
    secret = create(:secret)
    sign_in(my_user)
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "this is title"
    expect(page).not_to have_content "Edit"
    expect(page).not_to have_content "Destroy"
  end

  scenario "Login user can edit his post" do
    my_user = create(:user)
    secret = create(:secret, author: my_user)
    sign_in(my_user)
    click_link "Edit"
    fill_in "Title", with: "Hello world"
    fill_in "Body", with: "Mother fucker"
    click_button "Update Secret"
    expect(page).to have_content "Secret was successfully updated."
    expect(page).to have_content "Hello world"
    expect(page).to have_content "Mother fucker"
  end

  scenario "Login user can destroy his post" do
    my_user = create(:user)
    secret = create(:secret, author: my_user)
    sign_in(my_user)
    click_link "Destroy"
    expect(page).to have_content "Secret was successfully destroyed."
  end

  scenario "user can successfully logout" do
    my_user = create(:user)
    sign_in(my_user)
    sign_out
    expect(page).to have_content "You've successfully signed out"
  end

  scenario "signed in user can create new secret" do
    my_user = create(:user)
    sign_in(my_user)
    click_link "New Secret"
    fill_in "Title", with: "what?"
    fill_in "Body", with: "fuckers"
    click_button "Create Secret"
    expect(page).to have_content "Secret was successfully created."
  end

  #sad path
  scenario "Not sign_in user can not create secret" do
    click_link "New Secret"
    expect(page).to have_content "Not authorized, please sign in!"
  end

end

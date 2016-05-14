require 'rails_helper'

# 'feature' is an alias for 'desribe'
feature 'Users' do

  # before all specs goto home page.
  before do
    visit root_path
  end

  # 2. As a visitor I want to sign up.
  # 1. click on 'All Users' link
  # 2. click on 'New User' link
  # 3. fill in form and click button

  # `scenario` is an alias for `it`
  scenario 'create a new user' do

    # go to the signup page
    click_link "All Users"

    # go to the new user page
    click_link "New User"

    # fill in the form for a new user
    name = "Steven Chang"
    fill_in "Name", with: name
    fill_in "Email", with: "prime_pork@hotmail.com"
    fill_in "Password", with: "clamocop"
    fill_in "Password confirmation", with: "clamocop"

    # submit the form and verify it created a user
    expect{ click_button "Create User" }.to change(User, :count).by(1)

    # verify that the flash message is working
    expect(page).to have_content "User was successfully created."

    # verify that we've been redirected to that user's page
    expect(page).to have_content "#{name}"

    # logout
    click_link "Logout"
  end

  context "User already has an account" do
    before do
      # First we gotta create an account
      # go to the signup page
      click_link "All Users"

      # go to the new user page
      click_link "New User"

      # fill in the form for a new user
      name = "Steven Chang"
      fill_in "Name", with: name
      fill_in "Email", with: "prime_pork@hotmail.com"
      fill_in "Password", with: "clamocop"
      fill_in "Password confirmation", with: "clamocop"
      click_button "Create User"

      # At this point the user is signed in
    end

    # 3. As a not-signed-in user, I want to sign in to my account
    # 1. click on Login
    # 2. fill out form and submit
    # 3. Check that the login was successful
      # a. flash
      # b. logged-in page has user's name? 
    scenario "log in to account" do
      # Because the user is currently signed in, we gotta sign them out.
      click_link "Logout"

      # goto sign in page
      click_link "Login"

      # fill out form and submit
      fill_in "Email", with: 'prime_pork@hotmail.com'
      fill_in "Password", with: 'clamocop'
      click_button "Log in"

      expect(page).to have_content 'Welcome'
      # expect page to have_content 'Welcome' or 'Logout'
    end

    # 4. As a signed-in user, I want to be able to create a secret.
      # 1. Click on link "New Secret"
      # 2. Fill out "Title" and "Body" and click_on "Create Secret"
      # 3. Expect
        # a. Test that the secret count went up by 1
        # b. Test that the flash (success) message has appeared
    scenario "signed in user can create a new secret" do
      # currently we're on the page straight after logging in - the welcome page signed in page

      # Goto the secrets index page
      click_link "All Secrets"

      # Goto the page to create a new secret
      click_link "New Secret"

      # filling in the form and submitting
      fill_in "Title", with: "RL Grime"
      fill_in "Body", with: "Who do the shit that I do?"

      # Test that the secret count went up by 1
      expect{ click_button "Create Secret" }.to change(Secret, :count).by(1)

      # Test that the flash (success) message has been displayed.
      expect(page).to have_content "Secret was successfully created."

    end

    context "signed in user has just created a new secret" do

      before do
        # Goto the secrets index page
        click_link "All Secrets"

        # Goto the page to create a new secret
        click_link "New Secret"

        # filling in the form and submitting
        fill_in "Title", with: "RL Grime"
        fill_in "Body", with: "Who do the shit that I do?"

        # Test that the secret count went up by 1
        click_button "Create Secret"
      end

      # 5. As a signed-in user, I want to be able to edit one of my secrets
        # 1. Click on the "Edit" link
        # 2. fill_in forms again
        # 3. submit and expect that the Secret count doesn't change
        # 4. expect
          # a. successful flash message
          # b. So I want to test that update actually happened, aka we can't find the old title or body.
          # c. Continuing from before, I want to test that we can find updated title and body
      scenario "signed in user can edit one of their secrets" do
        # Goto the edit secret page
        click_link "Edit"

        # filling in the form
        fill_in "Title", with: "YOB "
        fill_in "Body", with: "Grrrrrrrrrrrrrr"

        # Test that the secret count hasn't changed
        expect{ click_button "Update Secret" }.to change(Secret, :count).by(0)

        # Test that the successful flash message is displayed aka we've been redirected to the correct page
        expect(page).to have_content "Secret was successfully updated."

        # Update successful so previous title and body is gone...
        expect(page).not_to have_content "RL Grime"
        expect(page).not_to have_content "Who do the shit that I do?"

        # Update success so new title and body should be present...
        expect(page).to have_content "YOB "
        expect(page).to have_content "Grrrrrr"
      end

      # 6. As a signed-in user, I want to be able to delete one of my secrets
        # 1. click_link "All Secrets" to goto the secrets index page
        # 2. click_link "Destroy" and expect Secret count to change by -1
      scenario "signed in user can delete one of their secrets" do
        # Goto the Secrets index page
        click_link "All Secrets"

        # click_link "Destroy"
        expect{ click_link "Destroy" }.to change(Secret, :count).by(-1)

        # No need to deal with the pop-up confirmation box because I think Capybara bypasses that.
      end

    end

  end

end
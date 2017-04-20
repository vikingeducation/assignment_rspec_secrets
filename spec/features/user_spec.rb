require 'rails_helper'


describe 'User' do
  let(:user){ create(:user)}
  let(:secret){ create(:secret)}
  let(:secrets){ create_list(:secret, 5)}
  let(:users){ create(:users, 5)}
  feature 'Accounts' do
    before do
      secrets
      visit root_path
    end
    context "when signed out" do
      scenario "Root path should show all secrets" do
        expect(page).to have_content("Listing secrets")
      end
      scenario "can view all secrets" do
        click_link "All Secrets"
        expect(current_path).to eq(secrets_path)
      end
      scenario "can view all users" do
        click_link "All Users"
        expect(current_path).to eq(users_path)
      end
      scenario "cannot see author of a secret" do
        expect(page).to have_content("**hidden**")
      end
      scenario "clicking on \"show\" for individual users leads to login page" do
        visit users_path
        first(:link, 'Show').click
        expect(current_path).to eq(new_session_path)
      end
      scenario "can click on link to view a secret" do
        first(:link, 'Show').click
        expect(current_path).not_to eq(new_session_path)
      end
      scenario "can sign in" do
        sign_in(user)
        expect(page).to have_content("Welcome, #{user.name}!")
      end
      scenario "attempt to create secret leads to login page" do
        click_link "New Secret"
        expect(current_path).to eq(new_session_path)
      end
      scenario "can click link to sign up" do
        visit users_path
        click_link "New User"
      end
      scenario "can sign up" do
        visit new_user_path
        within('.new_user') do
          fill_in 'Name', with: 'John'
          fill_in 'Email', with: 'Appleseed'
          fill_in 'Password', with: 'foobar'
          fill_in 'Password confirmation', with: 'foobar'
        end
        expect{ click_button "Create User" }.to change(User, :count).by(1)
        expect(page).to have_content "User was successfully created."
      end
    end
  end
  feature "Authentication" do
    let(:user){ create(:user) }
    before do
      visit new_session_path
    end
    context 'with improper credentials' do
      before do
        user.email = user.email + "x"
        sign_in(user)
      end
      scenario "does not allow sign in" do
        expect(current_path).to eq(session_path)
      end
    end
    context "with proper credentials" do
      scenario "can sign in to account" do
        sign_in(user)
        expect(page).to have_content "Welcome, #{user.name}!"
      end
    end
    context "after signing out" do
      scenario "signs out the user" do
        sign_in(user)
        sign_out
        expect(page).to have_content "Login"
      end
    end
    feature 'CRUD-ing secrets' do
      let(:secret){ create(:secret)}

      before do
        sign_in(user)
      end
      scenario "can create a secret" do
        create_valid_secret
        expect{ click_button "Create Secret" }.to change(Secret, :count).by(1)
        expect(page).to have_content "Secret was successfully created."
      end
      scenario "gets feedback when invalid secret created" do
        create_invalid_secret
        expect(page).to have_content("Title is too short")
        expect(page).to have_content("Body is too short")
      end
      scenario "can easily return to index after secret creation" do
        create_valid_secret
        click_link "Back"
        expect(current_path).to eq(secrets_path)
      end
      scenario "has link to edit own secret when on page" do
        s = user.secrets.create(title: 'Blah', body: 'Blahbla')
        visit secret_path(s.id)
        expect(page).to have_content "Edit"
      end
      scenario "cannot see link to edit someone else's secret when checking it out" do
        s = create_secret_for(create(:user))
        visit secret_path(s)
        expect(page).not_to have_content "Edit"
      end
      scenario "can see link to destroy own secret on secrets index page" do
        s = create_secret_for(user)
        visit secrets_path
        expect(page).to have_content("Destroy")
      end
    end
    feature 'CRUD-ing users' do
      before do
        sign_in(user)
      end
      scenario 'has link to destroy self on user listing page' do
        visit users_path
        expect(page).to have_content('Destroy')
      end
      scenario 'no link to destroy another user on that user\'s page' do
        visit user_path(create(:user))
        expect(page).not_to have_content('Destroy')
      end
      scenario 'deleting self takes user to rooth path' do
        visit users_path
        click_link 'Destroy'
        expect(current_path).to eq(users_path)
      end
    end
  end
end

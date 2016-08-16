require 'rails_helper'

feature 'Visitor Accounts' do
  before do
    visit root_path
  end

  scenario 'can view all secrets' do
    expect(page).to have_selector('h1', text: "Listing secrets")
  end

  scenario 'trying to make a new secret redirects to login page' do
    click_on('New Secret')

    expect(current_path).to eql(new_session_path)
  end

  scenario "is unable to see the authors of secrets" do
    secret = create(:secret)
    visit root_path

    expect(page).to have_content("**hidden**")
    expect(page).to_not have_content(secret.author.name)
  end

  scenario "is unable to view another user's show page" do
    create(:user)
    click_on "All Users"
    click_on "Show"
    expect(current_path).to eql(new_session_path)
  end

  scenario "is unable to destroy a user" do
    create(:user)
    click_on "All Users"
    expect { click_on "Destroy" }.to change(User, :count).by(0)
    expect(current_path).to eql(new_session_path)
  end

  scenario 'can sign up' do
    visit users_path
    click_link('New User')
    fill_in('Name', with: 'Bob')
    fill_in('Email', with: 'bob@email.net')
    fill_in('Password', with: "password")
    fill_in('Password confirmation', with: "password")

    expect { click_on('Create User') }.to change(User, :count).by(1)
    expect(page).to have_content('User was successfully created.')
    expect(page).to have_content('Bob')
  end

  scenario 'rejects a user with invalid email' do
    visit users_path
    click_link('New User')
    fill_in('Name', with: 'Bob')
    fill_in('Email', with: '')
    fill_in('Password', with: "password")
    fill_in('Password confirmation', with: "password")

    expect { click_on('Create User') }.to change(User, :count).by(0)
    expect(page).to have_content("Email can't be blank")
  end

  scenario 'is able to sign in to an account' do

    user = create(:user)
    sign_in(user)
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content(user.name)

  end
end

feature "Signed In Users" do
  before do
    visit root_path
    @user = create(:user)
    sign_in(@user)
  end

  scenario "is able to create a secret" do
    click_on "New Secret"
    fill_in "Title", with: "Title of Secret"
    fill_in "Body", with: "This is my secret"
    expect { click_on "Create Secret" }.to change(Secret, :count).by(1)

    expect(page).to have_content("Title of Secret")
    expect(page).to have_content("Secret was successfully created.")
  end

  scenario "is able to update a secret's title and body through the edit form" do
    create_secret
    secret_title = "Title of New Secret"
    click_on "Edit"
    fill_in "Title", with: secret_title
    fill_in "Body", with: "This an edited secret"
    click_on "Update Secret"

    expect(page).to have_content secret_title
    expect(page).to have_content "Secret was successfully updated."
  end

  scenario "is able to delete a saved secret" do
    create_secret
    click_on "All Secrets"

    secret_title = @user.secrets.first.title

    within("tr", text: secret_title) do
      expect { click_on "Destroy" }.to change(Secret, :count).by(-1)
    end

    expect(page).to_not have_content secret_title
  end

  scenario "is unable to destroy another user" do
    user = create(:user)
    click_on "All Users"

    within("tr", text: user.email) do
      expect { click_on "Destroy" }.to change(User, :count).by(0)
    end

    expect(current_path).to eql(root_path)
  end

  scenario "is able to see the authors of secrets" do
    secret = create(:secret)
    visit root_path

    expect(page).to_not have_content("**hidden**")
    expect(page).to have_content(secret.author.name)
  end

  scenario "is able to logout" do
    click_on "Logout"
    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(@user.name)
    expect(page).to have_content("Login")
  end


end

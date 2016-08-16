require 'rails_helper'

feature 'Visitor Accounts' do
  before do
    visit root_path
  end

  scenario 'can view all secrets' do
    expect(page).to have_selector('h1', text: "Listing secrets")
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
    user = create(:user)
    sign_in(user)
  end

  scenario "is able to create a secret" do
    click_on "New Secret"
    fill_in "Title", with: "Title of Secret"
    fill_in "Body", with: "This is my secret"
    expect { click_on "Create Secret" }.to change(Secret, :count).by(1)

    expect(page).to have_content("Title of Secret")
    expect(page).to have_content("Secret was successfully created.")
  end

  scenario "is able to edit a secret" do
    create_secret
    within("tr", text: user.secrets.first.title) do
      click_on "Edit"
    end

  end

end

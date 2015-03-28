require 'rails_helper'

feature 'Visitors' do

  let(:user){ create(:user) }

  before do
    visit root_path
  end

  scenario 'can view the secrets.' do
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "Title"
    expect(page).to have_content "Body"
    expect(page).to have_content "Author"
  end

  scenario 'can sign up.' do
    click_link 'All Users'
    expect(current_path).to eq users_path
    click_link 'New User'
    expect(current_path).to eq new_user_path

    name = "Foo"
    password = "password123"
    fill_in "Name", with: name
    fill_in "Email", with: "#{name}@email.com"
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password

    expect{ click_button "Create User" }.to change(User, :count).by 1
    expect(page).to have_content "User was successfully created."
    expect(page).to have_content "Welcome, #{name}"
  end
end


feature 'A signed-out user' do

  let(:user){ create(:user) }

  scenario 'can sign in.' do
    sign_in(user)

    expect(current_path).to eq root_path
    expect(page).to have_content "Welcome, #{user.name}"
    expect(page).to have_content "Logout"
  end
end

feature 'A signed-in user' do

  let(:user){ create(:user) }

  before do
    sign_in user
  end

  scenario 'can create a secret.'
  scenario 'can edit one of my secrets.'
  scenario 'can delete one of my secrets.'
end



# Think through the sad (and/or bad) paths that accompany those happy paths. Don't go too crazy (unless you want to) -- this should only require 15-or-so examples in total.
# Write integration tests that build test coverage for those paths. Remember your Red-Green-Refactor approach.
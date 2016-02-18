# As a visitor, I want to view all secrets

# As a visitor, I want to sign up
# Blank/invalid attributes invalidate signup
# Already logged-in users should not be able to sign up again

# As a not-signed-in user, I want to sign in to my account
# Blank/invalid inputs
# User doesn't exist

# As a signed-in user, I want to be able to create a secret
# Blank/invalid title or body filled in prevents creating
# visitors shouldn't be able to create

# As a signed-in user, I want to be able to edit one of my secrets
# same as new secret
# shouldn't be able to edit another user's secret

# As a signed-in user, I want to be able to delete one of my secrets
# Shouldn't be able to delete someone else's secret

require 'rails_helper'

feature "View Secrets" do
  before do
    create_list(:secret, 5)
  end

  scenario "visitor viewing secrets sees the secrets" do
    visit(secrets_path)

    expect(page).to have_selector('table tbody tr td')
  end

  scenario "visitor can see a particular secret" do
    body = "I'm a secret"
    create(:secret, body: body)
    visit(secrets_path)

    expect(page).to have_content(body)
  end

  scenario "visitor sees hidden author" do
    visit(secrets_path)
    expect(page).to have_content("**hidden**")
  end
end

feature "Sign Up" do

  before do
    visit(root_path)
    find_link('All Users').click
    find_link('New User').click
  end

  scenario "User is on new user page" do
    expect(current_path).to eq(new_user_path)
  end

  context 'User signed in' do
    before do
      fill_in 'Name', with: 'Foo'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
    end

    scenario "new user can sign up" do
      expect{ click_button('Create User') }.to change(User, :count).by(1)
    end

    scenario "Redirects to new user's page" do
      click_button('Create User')
      user = User.find_by_email('foo@bar.com')
      expect(current_path).to eq(user_path(user))
    end

    scenario "Page has user's email" do
      click_button('Create User')
      expect(page).to have_content('foo@bar.com')
    end
  end

  context "User has invalid information" do
    scenario "User can't sign up without name" do
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario "User can't sign up without email" do
      fill_in 'Name', with: 'Foo'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario "User can't sign up without password" do
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Name', with: 'Foo'
      fill_in 'Password confirmation', with: 'foobar'
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario "User can't sign up without password confirmation" do
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Name', with: 'Foo'
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario "User can't sign up with mismatched passwords" do
      fill_in 'Name', with: 'Foo'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'barfoo'
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario 'Invalid signup rerenders new user page' do
      fill_in 'Name', with: 'Foo'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'barfoo'
      click_button('Create User')
      expect(current_path).to eq(new_user_path)
    end
  end
end
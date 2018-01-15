require 'rails_helper'

RSpec.feature User, type: :feature do
  before do
    visit root_path
  end

  context 'Visitors' do
    scenario "As a visitor, I want to view all secrets" do
      expect(page).to have_selector('#spec_secrets_table')
    end

    scenario "As a visitor, I want to sign up" do
      click_link('Sign up')

      name = 'foo'
      fill_in('Name', with: name)
      fill_in('Email', with: "#{name}#@email.com")
      fill_in('Password', with: 'password')
      fill_in('Password confirmation', with: 'password')

      expect{ click_button("Create User") }.to change(User, :count).by(1)
      expect(page).to have_content(name)
      expect(page).to have_content("User was successfully created")
    end
  end

  context 'User accounts' do
    scenario "As a not-signed-in user, I want to sign in to my account"
    scenario "As a signed-in user, I want to be able to create a secret"
    scenario "As a signed-in user, I want to be able to edit one of my secrets"
    scenario "As a signed-in user, I want to be able to delete one of my secrets"
  end


end

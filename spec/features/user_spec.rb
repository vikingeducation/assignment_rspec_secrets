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
    
  end
end

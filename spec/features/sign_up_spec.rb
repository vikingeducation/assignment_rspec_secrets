require 'rails_helper'

feature 'sign up as a user' do
  before do
    visit users_path
  end

  scenario 'create a new user' do
    old_user_count = User.count
    signup({name: 'Morgan', email: 'admin@example.com', password: 'foobar', confirmation: 'foobar'})
    expect(User.count).to eq(old_user_count + 1)
    expect(page).to have_content('User was successfully created.')
  end

  scenario 'create a new user and password confirmation is incorrect' do
    signup({name: 'Morgan', email: 'admin@example.com', password: 'foobar', confirmation: 'doesntmatch'})
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'create a new user with an email that has already been taken' do
    signup({name: 'Morgan', email: 'admin@example.com', password: 'foobar', confirmation: 'foobar'})

    signup({name: 'Morgan', email: 'admin@example.com', password: 'foobar', confirmation: 'foobar'})
    expect(page).to have_content('Email has already been taken')
  end
end

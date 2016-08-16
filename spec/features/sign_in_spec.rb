require 'rails_helper'

feature 'sign in as a user' do
  let(:user) { create(:user) }

  scenario 'want to sign in as an already signed up user' do
    login(user)
    expect(page).to have_content('Logout')
  end

  scenario 'user wants to sign in with wrong password' do
    login(user, 'badpass')
    expect(page).to_not have_content('Logout')
  end
end

require 'rails_helper'

feature 'Users' do

  let (:user){ create(:user) }

  before do
    visit root_path
  end

  context 'without sign-in' do
    scenario 'allows viewing of all secrets'
    scenario 'does not allow creation of a secret'
    scenario 'does not allow editing a secret'
    scenario 'does not allow deleting a secret'
    scenario 'allows sign up'
  end

  context 'with improper credentials' do
    before do
      user.email += "x"
      sign_in(user)
    end

    scenario 'does not allow sign in' do
      expect(page).to have_content "We couldn't sign you in"
    end
  end

  context 'with proper credentials' do
    before do
      sign_in(user)
    end

    scenario 'allows sign in' do
      expect(page).to have_content "You've successfully signed in"
    end

    scenario 'allows creation of a secret'
    scenario 'allows editing of my secrets'
    scenario 'allows deleting of my secrets'
    scenario 'signs me out'
  end
end

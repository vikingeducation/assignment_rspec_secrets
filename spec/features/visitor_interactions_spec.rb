require 'rails_helper'

RSpec.feature "VisitorInteractions", type: :feature do
  feature 'Visitor interacts with application' do
    scenario 'Viewing secrets' do
      visit root_path
      expect(page).to have_content 'Listing secrets'
    end

    scenario 'Signing up' do
      name = 'Joe Sephus'
      email = "#{name}@example.com"
      password = 'f00f00'

      visit root_path
      click_link 'Sign up'

      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Create User'

      expect(page).to have_content name
      expect(page).to have_content email
      expect(page).to have_content 'User was successfully created.'
    end
  end
end

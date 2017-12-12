require 'rails_helper'

RSpec.feature 'LoggedInUserInteractions', type: :feature do

  feature 'Creating secrets' do
    scenario 'Logged in user creates secret' do
      user = create(:user)
      sign_in user

      visit root_path
      click_link 'New Secret'
      expect(current_path).to eq new_secret_path

      expected_title = 'Some Title'
      expected_secret = 'Shh. Here is my secret...'

      fill_in 'Title', with: expected_title
      fill_in 'Body', with: expected_secret
      click_button 'Create Secret'

      expect(page).to have_content 'Secret was successfully created.'
      expect(page).to have_content expected_title
      expect(page).to have_content expected_secret
    end

    scenario 'Non-user tries to create secret' do
      visit root_path
      click_link 'New Secret'
      expect(current_path).to eq new_session_path
    end
  end

  feature 'Editing secrets' do
    scenario 'Logged in user edits secret' do
      user = create(:user)
      user.secrets.create title: 'Sample secret', body: 'Some secret thing...'
      sign_in user

      visit root_path
      click_link 'Edit'
      expect(current_path).to eq edit_secret_path(user.secrets.first)

      changed_title = 'New Title!'
      fill_in 'Title', with: changed_title
      click_button 'Update Secret'

      expect(page).to have_content 'Secret was successfully updated.'
      expect(page).to have_content changed_title
    end
  end

  feature 'Deleting secrets' do
    scenario 'Logged in user deletes secret' do
      deletable_title = 'Sample secret'
      user = create(:user)
      user.secrets.create title: deletable_title, body: 'Some secret thing...'
      sign_in user

      visit root_path
      click_link 'Destroy'

      expect(current_path).to eq secrets_path
      expect(page).not_to have_content deletable_title
    end
  end
end

require 'rails_helper'

feature 'edit secret when signed in' do
  let(:user) { create(:user) }

  scenario 'edit secret when signed in' do
    login(user)
    click_link('New Secret')
    fill_in('Title', with: 'My Secret Title')
    fill_in('Body', with: 'My Secret Body')
    click_button('Create Secret')
    click_link('Edit')
    fill_in('Title', with: 'My Secret Title Edited')
    fill_in('Body', with: 'My Secret Body Edited')
    click_button('Update Secret')
    expect(page).to have_content("Secret was successfully updated.")
  end

  # scenario 'create secret without being logged in' do
  #   visit root_path
  #   expect(page).to_not have_content('Create Secret')
  # end
end

require 'rails_helper'

feature 'as a signed in user want to create a secret' do
  let(:user) { create(:user) }

  scenario 'create secret' do
    old_num_secrets = Secret.count
    login(user)
    click_link('New Secret')
    fill_in('Title', with: 'My Secret Title')
    fill_in('Body', with: 'My Secret Body')
    click_button('Create Secret')
    expect(Secret.count).to eq(old_num_secrets + 1)
  end

  scenario 'create secret without being logged in' do
    visit root_path
    expect(page).to_not have_content('Create Secret')
  end
end

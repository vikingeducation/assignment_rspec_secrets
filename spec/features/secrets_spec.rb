require 'rails_helper'

feature 'Secrets' do
  let(:user) { create( :user ) }
  let(:secret) { create( :secret ) }

  before do
    visit root_path
  end

  scenario 'show all secrets' do
    # expect(page).to have_content 'Listing secrets' # Works
    expect(page).to have_css('h1', text: 'Listing secrets')
  end

  scenario 'signed in user creates a secret' do
    sign_in(user)

    click_link "New Secret"

    fill_in 'Title', with: 'SHHHH'
    fill_in 'Body', with: 'This is a big secret.'

    click_button 'Create Secret'

    expect(page).to have_content 'Secret was successfully created.'
  end

  scenario 'signed in user can edit thier secret' do
    secret.author = user
    secret.save

    sign_in( user )

    click_link 'Edit'
    click_button 'Update Secret'

    expect(page).to have_content 'Secret was successfully updated.'
  end

  scenario 'signed in user cannot save a secret edit without a body' do
    secret.author = user
    secret.save

    sign_in( user )

    click_link 'Edit'

    fill_in 'Body', with: ''
    click_button 'Update Secret'

    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario 'signed in user can delete thier secret' do
    secret.author = user
    secret.save

    sign_in( user )

    click_link 'Destroy'

    expect(page).not_to have_content( secret.title )
  end



end

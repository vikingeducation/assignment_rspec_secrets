require 'rails_helper'

feature 'Secrets' do
  before do
    visit root_path
  end

  scenario 'show all secrets' do
    # expect(page).to have_content 'Listing secrets' # Works
    expect(page).to have_css('h1', text: 'Listing secrets')
  end

  


end

require 'rails_helper'

# 'feature' is an alias for 'describe'
feature 'Secrets' do

  before do
    # go to the home page
    visit root_path
  end

  # 'scenario' is an alias for 'it'
  # 1. As a visitor, I want to view all secrets - Well the link on the page says 'All Secrets' but the page only displays 5 secrets.
  scenario 'home page lists some secrets' do
    expect(page).to have_content "Listing secrets"
  end

end
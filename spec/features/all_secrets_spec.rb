require 'rails_helper'

feature 'All secrets' do
  before do
    5.times { create(:secret) }
    visit root_path
  end

  scenario 'view all secrets' do
    expect(page).to have_css('table tbody tr', count: (Secret.count))
  end

end

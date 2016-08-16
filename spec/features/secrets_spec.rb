require 'rails_helper'



feature 'Secrets' do
  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    visit root_path
  end
  let(:author) { create(:author) }


  scenario "view all secrets as a visitor" do
    author.secrets << create_list(:secret, 10)
    author.save!
    visit root_path
    expect(page).to have_content "Secret Body"
  end

  scenario "sign up as a visitor" do
    click_link 'All Users'
    click_link 'New User'
    fill_in_signup(author)
    save_and_open_page
    
    # expect{click_button 'Create User'}.to change(User, :count).by(1)
  end

end

  # scenario ""

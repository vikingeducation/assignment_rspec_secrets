require 'rails_helper'

feature 'viewing secrets' do
  before do
    visit root_path
  end
  
  scenario 'visitor first brought to secrets index' do
    expect(page).to have_content('Listing secrets')
  end

  scenario 'visitor clicks secrets link from another page' do
    click_link("All Users")
    click_link("All Secrets")
    expect(page).to have_content('Listing secrets')
  end
end

feature 'user accounts' do
  before do
    visit root_path
  end

  scenario 'visitor signs up' do
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "12345678")
    expect{ click_button "Create User" }.to change(User, :count).by(1)
  end
end
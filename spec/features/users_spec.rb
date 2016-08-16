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

feature 'creating user accounts' do
  before do
    visit root_path
  end

  scenario 'visitor signs up' do
    sign_up
    expect{ click_button "Create User" }.to change(User, :count).by(1)
    expect(page).to have_content('User was successfully created.')
  end

  scenario 'visitor cannot sign up with email that has already been used' do
    sign_up
    click_button("Create User")
    sign_up
    expect{ click_button "Create User"}.not_to change(User, :count)
    expect(page).to have_content('Email has already been taken')
  end

  scenario 'visiting cannot sign up with incorrect password confirmation' do
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "123456789")
    expect{ click_button "Create User"}.not_to change(User, :count)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end

feature 'using user accounts' do

  before do
    visit root_path
    sign_up
    click_link("Logout")
  end







end













require 'rails_helper'

#sign up
#should be able to sign up as new user
#should not be able to sign up as new user when already logged in
feature 'sign up new user' do

  before do
    # create(:secret)
    visit root_path
  end

  scenario 'should add a new user' do
    click_link "All Users"
    click_link "New User"
    name = "tester"
    fill_in "Name", with: name
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    expect{click_button "Create User"}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{name}")
    expect(page).to have_content("User was successfully created.")
  end

  scenario 'should be able to sign up as new user'
end

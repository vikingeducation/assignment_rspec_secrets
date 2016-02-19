require 'rails_helper'


feature 'logging in' do

  let(:user){ create(:user, :email => 'foo0@bar.com', :password => 'foobar') }

  before do
    visit root_path
  end

  scenario 'login button is present' do
    expect(page).to have_content('Login')
    expect(page).to have_selector("a[href='/session/new']")

    # mention in group scrum:
    expect(page).to have_link("Login", :href => new_session_path)
  end

  scenario 'visitor is able to login' do
    user

    log_in(user)

    expect(page).to have_content('Username')
    expect(page).to_not have_content('hidden')
  end
end


feature 'signing up' do

before do
  visit users_path
end

  scenario 'vistor is able to sign up' do
    click_on('New User')

    fill_in('Name', :with => 'Julia')
    fill_in('Email', :with => 'julia@bar.com')
    fill_in('Password', :with => 'foobar')
    fill_in('Password confirmation', :with => 'foobar')

     click_on('Create User')

     expect(page).to have_content('User was successfully created.')
  end

end

feature 'logout' do
  let(:user){ create(:user, :email => 'foo0@bar.com', :password => 'foobar') }

  scenario 'logged in user can log out' do
    user
    log_in(user)

    expect(page).to have_link('Logout', href: session_path)

    click_link('Logout')

    expect(page).to have_link('Login', href: new_session_path)
  end

end
require 'rails_helper'



feature 'view secrets as a visitor' do

  before do
    visit root_path
  end

  scenario 'secrets table is visible' do
    expect(page).to have_css('body > table > thead > tr > th')
    expect(page).to have_content('Title')
    expect(page).to have_content('Body')
    expect(page).to have_content('Author')
  end

end


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

feature 'creating a new secret' do

  let(:user){ create(:user, :email => 'foo0@bar.com', :password => 'foobar') }
  
  scenario 'logged in user can create a new secret' do
    user
    log_in(user)
    click_on('All Secrets')
    click_on('New Secret')

    fill_in('Title', :with => 'Secret1')
    fill_in('Body', :with => 'This is a secret body.')

    click_on('Create Secret')

     expect(page).to have_content('Secret was successfully created.')
  end
end

feature 'editing a secret' do

   let(:secret){ create(:secret) }

  scenario 'logged in user can edit their secrets' do
    secret
    log_in(secret.author)

    visit edit_secret_path(secret)
    fill_in('Body', :with => 'This is an edited secret body.')
    click_on('Update Secret')

     expect(page).to have_content('Secret was successfully updated.')

     expect(page).to have_content('This is an edited secret body.')

  end

end


















require 'rails_helper'

feature 'user interaction' do
  # As a visitor, I want to view all secrets
  context 'viewing secrets' do
    before do
      new_secret = create(:secret)
      visit root_path
    end
    scenario 'should view table of all secrets' do
      expect(page).to have_selector('table')
    end

    scenario 'should not have 1 table row when there is a secret' do
      expect(page).to_not have_selector('tr', count: 1)
    end

    scenario 'should not have 2 table rows when there is 1 secret' do
      expect(page).to have_selector('tr', count: 2)
    end
  end

  # As a visitor, I want to sign up
  context 'signing up' do
    before do
      visit users_path
      click_link('New User')
    end

    scenario 'clicking the New User link should bring me to a signup page' do
      expect(page).to have_css('#user_name')
    end

    scenario 'there should not be a users table on the signup page' do
      expect(page).to_not have_selector('table')
    end

    scenario 'user should not be able to sign up with invalid information' do
      fill_in 'user_name', with: 'a'
      fill_in 'user_email', with: 'b'
      fill_in 'user_password', with: "ddddddde"
      fill_in 'user_password_confirmation', with: "ddddddd"
      click_button 'Create User'
      expect(page).to have_css('#error_explanation')
    end

    scenario 'user should not be able to sign up with invalid email address' do
      fill_in 'user_name', with: 'abcdefg'
      fill_in 'user_email', with: 'b'
      fill_in 'user_password', with: "dddddddd"
      fill_in 'user_password_confirmation', with: "dddddddd"

      expect{click_button 'Create User'}.to change(User, :count).by(0)
    end

    scenario 'user should be able to sign up with valid information' do
      fill_in 'user_name', with: 'abcdefg'
      fill_in 'user_email', with: 'test@foo.bar'
      fill_in 'user_password', with: "dddddddd"
      fill_in 'user_password_confirmation', with: "dddddddd"
      expect{click_button 'Create User'}.to change(User, :count).by(1)
    end
  end

  # As a not-signed in user, I want to sign into my account
  context 'signing in' do
    before do
      @u = create(:user)
      @email = @u.email
      @pwd = @u.password
      visit new_session_path
    end

    scenario 'user should be able to sign in with their credentials' do
      fill_in 'email', with: @email
      fill_in 'password', with: @pwd
      click_button 'Log in'
      expect(page).to have_content("Welcome, #{@u.name}")
    end

    scenario 'user should not be able to sign in with wrong credentials' do
      fill_in 'email', with: "wrong@email.com"
      fill_in 'password', with: @pwd
      click_button 'Log in'
      expect(page).to_not have_content("Welcome, #{@u.name}")
    end

    scenario 'user should not be able to sign in if not registered' do
      @u.destroy
      fill_in 'email', with: @email
      fill_in 'password', with: @pwd
      click_button 'Log in'
      expect(page).to_not have_content("Welcome, #{@u.name}")
    end
  end

  # As a signed-in user, I want to be able to create a secret
  context 'as a signed in user, I can create a secret' do

    before do
      @u = create(:user)
      visit new_session_path
      fill_in 'email', with: @u.email
      fill_in 'password', with: @u.password
      click_button 'Log in'
      click_link 'New Secret'
    end
  
    scenario 'should not be brought to login page' do
      expect(current_url).to_not eq(new_session_url)
    end

    scenario 'new secret page does render' do
      expect(current_url).to eq(new_secret_url)
    end

    #happy path
    scenario 'entering valid information creates a secret' do
      fill_in 'secret_title', with: "New Secret"
      fill_in 'secret_body', with: "New secret body"
      expect{click_button 'Create Secret'}.to change(Secret, :count).by(1)
      expect(current_url).to eq(secret_url(Secret.last))
    end

    #sad path
    scenario 'entering invalid information gives errors' do
      fill_in 'secret_title', with: "N"
      fill_in 'secret_body', with: "1"*141
      expect{click_button 'Create Secret'}.to change(Secret, :count).by(0)
      expect(current_url).to eq(secrets_url)
      expect(page).to have_css('#error_explanation')
    end

  end

  context 'without signing in I can not create a secret' do

    before do
      visit root_path
      click_link 'New Secret'
    end
    
    scenario 'should be brought to login page' do
      expect(current_url).to eq(new_session_url)
    end

    scenario 'new secret page does not render' do
      expect(current_url).to_not eq(new_secret_url)
    end

  end

  # As a signed-in user, I want to be able to edit one of my secrets

  end












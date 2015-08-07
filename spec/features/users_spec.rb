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

    scenario 'user should be able to sign up with valid information' do
      expect(page).to have_css('#user_name') #clicking the New User link should bring me to a signup page
      expect(page).to_not have_selector('table') #there should not be a users table on the signup page
      fill_in 'user_name', with: 'abcdefg'
      fill_in 'user_email', with: 'test@foo.bar'
      fill_in 'user_password', with: "dddddddd"
      fill_in 'user_password_confirmation', with: "dddddddd"
      expect{click_button 'Create User'}.to change(User, :count).by(1)
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
      sign_in
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

    scenario 'should be brought to login page not secret page' do
      expect(current_url).to eq(new_session_url)
      expect(current_url).to_not eq(new_secret_url)
    end

  end

  # As a signed-in user, I want to be able to edit one of my secrets
  context 'as a signed in user, I can edit a secret' do

    before do
      sign_in
    end

    scenario 'should be able to go to edit page for authored secret' do
      new_secret = create(:secret, author: @u)
      visit root_path
      expect(page).to have_content("Edit")
      click_link("Edit")
      expect(current_url).to eq(edit_secret_url(new_secret))
    end

    scenario 'should not be able to go to the edit page for unowned secret' do
      create(:secret)
      visit root_path
      expect(page).to_not have_content("Edit")
    end

    scenario 'should not be able to input the edit url for an unowned secret' do
      new_secret = create(:secret)
      visit edit_secret_url(new_secret)
      expect(current_url).to eq(root_url)
    end

    context 'editing secrets' do
      before do
        new_secret = create(:secret, author: @u)
        visit root_path
        click_link("Edit")
      end
      scenario 'should be able to edit the contents of a secret' do
        fill_in "secret_body", with: "THIS IS A TEST"
        click_button "Update Secret"
        expect(current_url).to eq(secret_url(Secret.first))
        expect(page).to have_content("THIS IS A TEST")
      end

      scenario 'should not be able to edit the body with invalid parmas' do
        invalid_body = "T" * 999
        fill_in "secret_title", with: invalid_body
        click_button "Update Secret"
        expect(current_url).to eq(secret_url(Secret.first))
        expect(page).to have_selector("input[value=#{invalid_body}]")
        expect(page).to have_css('#error_explanation')
      end

      scenario 'should be able to edit the contents of a secret (title)' do
        fill_in "secret_title", with: "THIS IS A TEST TITLE"
        click_button "Update Secret"
        expect(current_url).to eq(secret_url(Secret.first))
        expect(page).to have_content("THIS IS A TEST TITLE")
      end

      scenario 'should not be able to edit the title with invalid parmas' do
        fill_in "secret_title", with: "TH"
        click_button "Update Secret"
        expect(current_url).to eq(secret_url(Secret.first))
        expect(page).to have_selector("input[value='TH']")
        expect(page).to have_css('#error_explanation')
      end
    end

    # As a signed-in user, I want to be able to delete one of my secrets
    context 'user can delete owned secret after sign in' do
     
      before do 
        sign_in
      end

      scenario 'destroy link should not be present on index page without owned secret' do
        create(:secret)
        visit root_path
        expect(page).to_not have_link('Destroy') 
      end

      scenario 'destroy link should be present on index page with owned secret' do
        create(:secret, :author => @u)
        visit root_path
        expect(page).to have_link('Destroy') 
      end

      scenario 'clicking destroy should delete the secret' do
        create(:secret, :author => @u)
        visit root_path
        expect{click_link('Destroy')}.to change(Secret, :count).by(-1)
        expect(page).to_not have_link('Destroy') 
      end

    end

  end
end












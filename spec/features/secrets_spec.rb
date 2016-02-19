require 'rails_helper'

feature 'Visit_Root_Page' do
  

  let(:NUM_SECRETS){ 5 }
  let(:user){ create(:user) }
  let(:secrets){create_list(:secret, 5, author: user)}

  context "visit root page as anonymus user" do

    before do
      secrets
      visit root_path
    end

    scenario "shows the secrets index page" do
      expect(page).to have_content "Listing secrets"
    end

    scenario "shows one row for each secret" do
      expect(page).to have_css('.secret-row', count: 5)
    end  

    scenario "login redirects to correct url" do
      click_link "Login"
      expect(current_path).to eq(new_session_path)
    end  

    scenario "shows users correctly" do
      click_link "All Users"
      expect(page).to have_css('.user-row', count: 1)
    end  

    scenario "can add user happy path" do
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      click_link "All Users"
      expect(page).to have_css('.user-row', count: 2)
    end  


    scenario "cannot add user wo password confirmation" do
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'koz')
      fill_in('Email', with: 'koz@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'otherpassword')
      click_button('Create User')
      click_link "All Users"
      expect(page).to have_css('.user-row', count: 1)
    end  

  end

  context "visit secrets as signed up user" do

    before do
      secrets
      create_user_deepa
      click_link "All Secrets"
      click_link "New Secret"
    end

    scenario "signed up user can go to new secret page" do
      expect(current_path).to eq(new_secret_path)
    end  

    scenario "signed up user can add a new secret" do
      expect(current_path).to eq(new_secret_path)
      fill_in('Title', with: 'My Secret')
      fill_in('Body', with: 'Very Secret')
      click_button('Create Secret')
      expect(page).to have_content "Very Secret"
    end  

    scenario "signed up user can edit a secret" do
      expect(current_path).to eq(new_secret_path)
      fill_in('Title', with: 'My Secret')
      fill_in('Body', with: 'Very Secret')
      click_button('Create Secret')
      click_link "Edit"
      fill_in('Title', with: 'My New Secret')
      fill_in('Body', with: 'Very New Secret')
      expect(page).to have_content "Very New Secret"
    end  

    scenario "signed up user can destroy a secret" do
      expect(current_path).to eq(new_secret_path)
      fill_in('Title', with: 'My Secret')
      fill_in('Body', with: 'Very Secret')
      click_button('Create Secret')
      click_link "All Secrets"
      click_link "Destroy"
      expect(page).to_not have_content "Very Secret"
    end  

  end

  context "sign_in / sign_out toggles secrets authors" do

    before do
      secrets
      visit secrets_path
    end

    scenario "hides secrets authors for anonymous users" do
      expect(page).to have_content('**hidden**')
    end  

    scenario "shows one row for each secret" do
      expect(page).to have_content('**hidden**', count: 5 )
    end  

    scenario "show secrets authors for logged in user" do
      create_user_deepa
      visit root_path
      expect(page).to_not have_content('**hidden**')
    end  
  end

  context "secrets validations work" do

    before do
      secrets
      visit secrets_path
      create_user_deepa
      visit root_path
    end

    scenario "makes secret for title and body within validations" do
      click_link 'New Secret'
      fill_in 'Title', with: 'this'
      fill_in 'Body', with: 'this'
      click_button 'Create Secret'
      expect(page).to have_content('Secret was successfully created.' )
    end  

    scenario "fails to create secret for  short title" do
      click_link 'New Secret'
      fill_in 'Title', with: 'art'
      fill_in 'Body', with: 'this'
      click_button 'Create Secret'
      expect(page).to_not have_content('Secret was successfully created.' )
    end  

    scenario "fails to create secret for short body" do
      click_link 'New Secret'
      fill_in 'Title', with: 'this'
      fill_in 'Body', with: 'art'
      click_button 'Create Secret'
      expect(page).to_not have_content('Secret was successfully created.' )
    end  

  end


end
require 'rails_helper'

feature 'Visit_Root_Page' do
  
  let(:user){ create(:user) }

  let(:secrets){create_list(:secret, 5, author: user)}

  context "visit root page as anonymus user" do
    # before do
    #   user.email = user.email + "x"
    #   sign_in(user)
    # end

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
      visit root_path
    end

    scenario "signed up user can go to new secret page" do
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      click_link "All Secrets"
      click_link "New Secret"
      expect(current_path).to eq(new_secret_path)
      #expect(page).to have_css('.user-row', count: 2)
    end  

    scenario "signed up user can add a new secret" do
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      click_link "All Secrets"
      click_link "New Secret"
      expect(current_path).to eq(new_secret_path)
      fill_in('Title', with: 'My Secret')
      fill_in('Body', with: 'Very Secret')
      click_button('Create Secret')
      #expect(page).to have_css('.user-row', count: 2)
      expect(page).to have_content "Very Secret"
    end  

    scenario "signed up user can edit a secret" do
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      click_link "All Secrets"
      click_link "New Secret"
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
      click_link "All Users" 
      click_link "New User" 
      fill_in('Name', with: 'deepa')
      fill_in('Email', with: 'deepa@x.com')
      fill_in('Password', with: 'foobar')
      fill_in('Password confirmation', with: 'foobar')
      click_button('Create User')
      click_link "All Secrets"
      click_link "New Secret"
      expect(current_path).to eq(new_secret_path)
      fill_in('Title', with: 'My Secret')
      fill_in('Body', with: 'Very Secret')
      click_button('Create Secret')
      click_link "All Secrets"
      click_link "Destroy"
      expect(page).to_not have_content "Very Secret"
    end  

  end

  # context "with proper credentials" do
  #   before do
  #     sign_in(user)
  #   end
  #   scenario "successfully signs in an existing user" do
  #     # verify we're on the user's show page now
  #     expect(page).to have_content "You've successfully signed in"
  #   end

  #   context "after signing out" do
  #     before do
  #       sign_out
  #     end
  #     scenario "signs out the user" do
  #       expect(page).to have_content "You've successfully signed out"
  #     end
  #   end
  # end
end
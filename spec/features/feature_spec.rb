require 'rails_helper'

feature 'Secrets App' do

  let(:user) { create(:user) }

  context "when signed out" do

    scenario 'lists all secrets when navigating to root path' do
      five_secrets = []
      5.times do
        five_secrets << create(:secret, :sequence_of)
      end
      visit ('/')
      expect(page).to have_content five_secrets[0].title
      expect(page).to have_content five_secrets[4].title
    end

    scenario 'allows visitor to sign up' do
      fill_in_sign_ups
      click_on("Create User")
      expect(page).to have_content "User was successfully created"
    end

    scenario 'when trying to sign up with blank name field, rerenders the sign up form with error messages' do
      fill_in_sign_ups
      fill_in('Name', :with => "")
      click_on("Create User")
      expect(page).to have_content "Name can't be blank"
    end

    scenario 'when trying to sign up with blank email field, rerenders the sign up form with error messages' do
      fill_in_sign_ups
      fill_in('Email', :with => "")
      click_on("Create User")
      expect(page).to have_content "Email can't be blank"
    end

    scenario 'when you bungle the password confirmation, rerenders the sign up form with errors' do
      fill_in_sign_ups
      fill_in('Password confirmation', :with => 'candlejack')
      click_on("Create User")
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'allows user to log in' do
      visit('session/new')
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_on("Log in")
      expect(page).to have_content "Welcome, #{user.name}"
    end

  end

  context "when logged in" do

    let(:secret) { build(:secret) }
    let(:user_secret) { create(:secret, author_id: user.id) }

    before do
      sign_in(user)
    end

    scenario 'allows user to create a secret' do
      click_link("New Secret")
      fill_in('Title', with: secret.title)
      fill_in('Body', with: secret.body)
      click_on('Create Secret')
      expect(page).to have_content('Secret was successfully created')
    end

    scenario 'when trying to create a blank secret, rerenders the secret form with error messages' do
      click_link("New Secret")
      click_on('Create Secret')
      expect(page).to have_content('Body can\'t be blank')
      expect(page).to have_content('Title can\'t be blank')
    end

    context 'when user has created a secret' do  

      scenario 'allows user to edit and update his own secret' do
        user_secret
        click_on('All Secrets')
        click_on("Edit")
        click_on('Update Secret')
        expect(page).to have_content('Secret was successfully updated.')
      end

      scenario 'does not allow user to edit another user\'s secret' do
        secret.save
        click_on('All Secrets')
        expect(page).not_to have_content "Edit"
      end

      scenario 'allows user to delete his own secret' do
        user_secret
        click_on('All Secrets')
        expect(page).to have_content secret.title
        click_on("Destroy")
        expect(page).to_not have_content secret.title
      end
      scenario 'does not allow user to delete another user\'s secret' do
        secret.save
        click_on('All Secrets')
        expect(page).not_to have_content "Destroy"
      end

    end

  end

end
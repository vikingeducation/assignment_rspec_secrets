require 'rails_helper'
require 'pry'
#creating secrets
#signed in user can create secret
#non-signed in user cannot create secret

feature 'Creating Secrets' do
  let(:user){ create(:user) }

  before do
    visit root_path
  end

  context "A sign in User" do
    before do
      sign_in(user)
      click_link "New Secret"
    end

    scenario 'signed-in user can view secret builder form' do
      expect(page).to have_content("New secret")
    end

    scenario 'create the secret' do
      title = "Test Secret"
      fill_in "Title", with: title
      fill_in "Body", with: "This is so secret"
      expect{click_button "Create Secret"}.to change(Secret, :count).by(1)
      expect(page).to have_content("Secret was successfully created.")
    end

    scenario 'fails to create secret if title less than 4 chars' do
      title = "no"
      fill_in "Title", with: title
      fill_in "Body", with: "This is so secret"
      expect{click_button "Create Secret"}.to change(Secret, :count).by(0)
      expect(page).to have_content("prohibited this secret from being saved:")
    end

    scenario 'fails to create secret if body less than 4 chars' do
      title = "This will fail"
      fill_in "Title", with: title
      fill_in "Body", with: "The"
      expect{click_button "Create Secret"}.to change(Secret, :count).by(0)
      expect(page).to have_content("prohibited this secret from being saved:")
    end

    scenario 'fails to create secret if title more than 24 chars' do
      title = "1"*25
      fill_in "Title", with: title
      fill_in "Body", with: "This is so secret"
      expect{click_button "Create Secret"}.to change(Secret, :count).by(0)
      expect(page).to have_content("prohibited this secret from being saved:")
    end

    scenario 'fails to create secret if body more than 140 chars' do
      title = "This will fail"
      fill_in "Title", with: title
      fill_in "Body", with: "1"*141
      expect{click_button "Create Secret"}.to change(Secret, :count).by(0)
      expect(page).to have_content("prohibited this secret from being saved:")
    end

  end

  context "Visiting user/non-signed user" do
    before do
      click_link "New Secret"
    end

    scenario 'Secret form does not load' do
      expect(page).to_not have_content("New secret")
    end

  end



end














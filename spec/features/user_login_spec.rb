#sign in
#existing user can sign in
#non-existing user cannot sign in
#can view author once signed in
#expect my name to be displayed on page with welcome msg
#can log out
require 'rails_helper'

feature 'Signing In/Signing Out' do
  let(:user){ create(:user) }
  before do
    visit root_path
  end

  context "As an existing user/correct login" do
    before do
      sign_in(user)
    end
    
    scenario "successfully signs in an exisiting user" do
      expect(page).to have_content "Welcome, #{user.name}"
    end
    
    scenario "can view authors of secrets" do
      expect(page).to_not have_content "**hidden**"
    end

    scenario "signed-in user can sign out" do
      sign_out
      expect(page).to have_content "Login"
    end
  
  end

  context "As a non-existing user/incorrect login" do
    before do
      user.email = user.email + "z"
      sign_in(user)
    end
    scenario "does not allow sign in" do
      expect(page).to_not have_content "Welcome, #{user.name}"
    end
  end



end

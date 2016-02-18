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

    scenario "shows the secrets index page" do
      expect(page).to have_css('.secret_row', count: 5)
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
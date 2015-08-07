require 'rails_helper'
require 'pry'
#deleting
#signed in user can delete their own secret
#signed in user cannot delete someone else's secret
#visitor cannot delete anyone's secret

feature 'Deleting Secrets' do
  let(:user){ create(:user) }

  before do
    visit root_path
  end

  context "A sign in User" do
    before do
      sign_in(user)
      user.secrets.create(title: "secret_test", body: "wooooop")
      user.save
      visit root_path
    end

    scenario 'can view Destroy button on their secret' do
      expect(page).to have_content("secret_test")
      expect(page).to have_content("wooooop")
      expect(page).to have_content("Destroy")
    end

    scenario 'destroy should remove secret' do
      click_link "Destroy"
      expect(page).to_not have_content("secret_test")
      expect(page).to_not have_content("wooooop")
    end
  end
end
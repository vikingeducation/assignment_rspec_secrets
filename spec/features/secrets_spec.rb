require 'rails_helper'

feature "Secrets" do 
  before do
    visit root_path
  end

  let(:author) { build(:author) }
  let(:secret) { build(:secret) }

  context "as a visitor" do

    scenario "view secrets" do
      click_link "All Secrets" 

      expect(page).to have_content "Listing secrets"
    end

  end
  




end
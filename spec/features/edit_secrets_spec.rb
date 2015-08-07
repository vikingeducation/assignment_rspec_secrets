require 'rails_helper'
require 'pry'
#editing secrets
#signed in user can edit their own secret
#signed in user cannot edit someone else's secret
#visitor cannot edit anyone's secret

feature 'Editing Secrets' do
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
    
    scenario 'signed-in user can view EDIT secret builder form' do
      click_link "Edit"
      expect(page).to have_content("Editing secret")
    end

    scenario 'Edit form has pre-existing secret info' do
      click_link "Edit"
      # expect(page).to have_content(user.secrets[0].body)
      expect(find_field('Title').value).to eq("secret_test")
    end

  end
end
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

    scenario 'can view EDIT secret builder form' do
      click_link "Edit"
      expect(page).to have_content("Editing secret")
    end

    scenario 'Edit form has pre-existing secret info' do
      click_link "Edit"
      # expect(page).to have_content(user.secrets[0].body)
      expect(find_field('Title').value).to eq("secret_test")
      expect(find_field('Body').value).to eq("wooooop")
    end

    scenario "can update their exisitng secret" do
      click_link "Edit"

      fill_in "Title", with: "secret_secret_test"
      fill_in "Body", with: "more body"
      click_button "Update Secret"

      expect(page).to have_content("Secret was successfully updated.")
      expect(page).to have_content("secret_secret_test")
      expect(page).to have_content("more body")
    end
  end

  context "Another User cannot edit someone else's secret" do

    before do
      sign_in(user)
      user.secrets.create(title: "secret_test", body: "wooooop")
      user.save
      sign_out
      new_user = create(:user, name: "new_foo")
      sign_in(new_user)
      visit root_path
    end

    scenario "there is no edit link for someone else's secret" do
      expect(page).to have_content("secret_test")
      expect(page).to_not have_content("Edit")
    end
  end

end
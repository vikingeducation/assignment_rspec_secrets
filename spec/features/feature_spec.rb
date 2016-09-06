require 'rails_helper'

feature 'User accoounts' do
  before do
    visit root_path
  end

  scenario "log in a user" do
    click_link "Login"
    fill_in "Email", with: ""
  end
end

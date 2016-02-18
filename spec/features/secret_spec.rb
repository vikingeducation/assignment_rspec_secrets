require 'rails_helper'



feature 'view secrets as a visitor' do

  before do
    visit root_path
  end

  scenario 'secrets table is visible' do
    expect(page).to have_css('body > table > thead > tr > th')
    expect(page).to have_content('Title')
    expect(page).to have_content('Body')
    expect(page).to have_content('Author')
  end

end


feature 'signing up' do

  before do
    visit root_path
  end

  scenario 'login button is present' do
    expect(page).to have_content('Login')
    expect(page).to have_selector("a[href='/session/new']")

    # mention in group scrum:
    expect(page).to have_link("Login", :href => new_session_path)
  end

  scenario 'visitor is able to sign up' do


  end



end
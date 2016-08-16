require 'rails_helper'

feature 'sign in as a user' do
  let(:user) { create(:user) }


  scenario 'want to sign in as an already signed up user' do
    login(user)
    expect(page).to have_content('Logout')
  end

  scenario 'user wants to sign in with wrong password' do
    login(user, 'badpass')
    expect(page).to_not have_content('Logout')
  end

  scenario "user will delete a secret when they are signed in" do 
    login(user)
    click_link('New Secret')
    fill_in('Title', with: 'My Secret Title')
    fill_in('Body', with: 'My Secret Body')
    click_button('Create Secret')
    click_link("All Secrets")
    click_link("Destroy")
    expect(Secret.count).to eq(0)
  end

  scenario "user cannot delete a secret if there are no secrets" do 
    login(user)
    click_link("All Secrets")
    expect(page).to_not have_content("Destory")
  end

end

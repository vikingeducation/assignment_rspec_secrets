require 'rails_helper'

feature 'Users' do
  let(:user) { create(:user) }

  before do
    visit root_path
  end

  scenario 'sign up to create user' do
    go_to_sign_up_page

    fill_in('Name', with: 'Fakey McFakerson')
    fill_in('Email', with: 'f@gmail.com')
    fill_in('Password', with: '111111')
    fill_in('Password confirmation', with: '111111')

    expect{ click_button('Create User') }.to change( User, :count).by 1
  end

  scenario 'error on sign up page when name is blank' do
    go_to_sign_up_page

    fill_in('Name', with: '')
    fill_in('Email', with: 'f@gmail.com')
    fill_in('Password', with: '111111')
    fill_in('Password confirmation', with: '111111')

    expect{ click_button('Create User') }.to_not change( User, :count)
    expect(page).to have_selector(:css, "div#error_explanation", text: "Name can't be blank")
  end

  scenario 'sign in' do
    sign_in( user )

    expect(page).to have_content "Welcome, #{user.name}!"
  end

  scenario 'sign in with bad password is unsuccessful' do

    sign_in( user, 'nonsense')

    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
  end

end

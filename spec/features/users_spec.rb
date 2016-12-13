require 'rails_helper'

feature 'Users' do
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

  scenario 'sign up to create user' do
    go_to_sign_up_page

    fill_in('Name', with: '')
    fill_in('Email', with: 'f@gmail.com')
    fill_in('Password', with: '111111')
    fill_in('Password confirmation', with: '111111')

    expect{ click_button('Create User') }.to change( User, :count).by 1
  end


end

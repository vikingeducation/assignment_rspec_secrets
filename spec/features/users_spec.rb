require 'rails_helper'

feature 'Actions as visitor' do
  before do
    visit root_path
  end

  context "viewing secrets" do
    scenario "successfully view page with a secret" do
      expect(page).to have_css('h1')
      expect(page).to have_content "Listing secrets"
      expect(page).to has_link?("Show")
    end
  end

  context "viewing specific secret - show" do
    scenario "successfully view page with a secret" do
      click_link('Show')
      page.assert_selector('p', count: 3)
      page.assert_selector('p#Author', count: 1)
      page.assert_selector('p#Body', count: 1)
      page.assert_selector('p#Title', count: 1)
    end
  end

  context "unable to create secrets" do
    scenario "login page appears" do
      click_link('New Secret')
      expect(page).to has_field("Password")
      expect(page).to has_field("Email")
      expect(page).to has_button("Log in")
    end
  end

  context "unable to see author of a secret" do
    scenario "seeing only hidden Author name" do
      expect(page).to have_content "**hidden**"
    end
  end
end


feature 'Signing up as visitor' do
  before do
    visit root_path
    click_link('All Users')
    click_link('New User')
  end

  context "with improper name" do
    fill_in('Name', :with => '1')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    expect(page).to have_content "Name is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  context "with improper email" do
    fill_in('Name', :with => 'Sanskir')
    fill_in('Email', :with => 'gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    # expect(page).to have_content "Name is too short"
    # expect(page).to have_css ('div#error_explanation')
  end

  context "with improper password" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'See')
    fill_in('Password confirmation', :with => 'See')
    # expect(page).to have_content "Name is too short"
    # expect(page).to have_css ('div#error_explanation')
  end

  context "with no password confirmation" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => '')
    # expect(page).to have_content "Name is too short"
    # expect(page).to have_css ('div#error_explanation')
  end

  context "with some fields empty" do
    fill_in('Name', :with => 'Lukas')
    fill_in('Email', :with => '')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    # expect(page).to have_content "Name is too short"
    # expect(page).to have_css ('div#error_explanation')
  end

end

feature 'Signing in to an account' do
  before do
    visit root_path
  end

  context "with improper email" do

  end

  context "with improper password" do

  end

end

feature 'Creating secret as signed in user' do
  before do
    visit root_path
  end

  context "with improper title" do

  end

  context "with improper body" do

  end

  context "with body missing" do

  end

end

feature 'Editing secret as signed in user' do
  before do
    visit root_path
  end

  context "with improper title" do

  end

  context "with improper body" do

  end

end


feature 'Deleting secret as signed in user' do
  before do
    visit root_path
  end

  context "deleting own secret" do

  end

  context "unable to delet other's secret" do

  end

end

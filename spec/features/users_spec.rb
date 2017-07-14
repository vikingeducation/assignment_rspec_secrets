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

  scenario "with improper name" do
    fill_in('Name', :with => '1')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_link "Sign up"
    expect(page).to have_content "Name is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper email" do
    fill_in('Name', :with => 'Sanskir')
    fill_in('Email', :with => 'gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_link "Sign up"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper password" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'See')
    fill_in('Password confirmation', :with => 'See')
    click_link "Sign up"
    expect(page).to have_content "Password is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with no password confirmation" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seewer')
    click_link "Sign up"
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with some fields empty" do
    fill_in('Name', :with => 'Lukas')
    fill_in('Email', :with => '')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_link "Sign up"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with correct data" do
    fill_in('Name', :with => 'Seek#{rand(123)}')
    fill_in('Email', :with => 'Seek#{rand(123)}@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_link "Sign up"
    expect(page).to have_content "Successfully"
    find_link('Logout').visible?
  end

end

feature 'Logging in to an account' do

  let(:user){User.first}
  before do
    visit root_path
    click_link('Login')
  end

  scenario "with improper email" do
    fill_in('Email', :with => 'daria@dar.pl')
    fill_in('Password', :with => 'Seekrit')
    click_link "Login"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper password" do
    fill_in('Email', :with => 'daria@dar.pl')
    fill_in('Password', :with => 'Seekrit')
    click_link "Login"
    expect(page).to have_content "Password is invalid"
    expect(page).to has_link?("Show")
    expect(page).to have_content "Listing secrets"
  end

  scenario "with correct login data" do
    sign_in(user)
    expect(page).to have_content "Listing secrets"
    expect(page).to has_link?("Show")
    expect(page).not_to have_content "**"
  end

end

feature 'Creating secret as signed in user' do
  let(:user){User.first}
  before do
    visit root_path
    sign_in(user)
    click_link "New Secret"
  end

  scenario "with improper title" do
    fill_in('Title', :with => '')
    fill_in('Body', :with => 'The owls are not what they seem. An amazing story catches every one involved in magic of this town.')
    click_link "Create Secret"
    expect(page).to have_content "Title is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper body" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => 'asd')
    click_link "Create Secret"
    expect(page).to have_content "Body is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with body missing" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => '')
    click_link "Create Secret"
    expect(page).to have_content "Body can't be blank."
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "successfull creation" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => 'The owls are not what they seem. An amazing story catches every one involved in magic of this town.')
    click_link "Create Secret"
    expect(page).to have_content "Secret was successfully created."
    expect(page).to have_css ('p#notice')
    expect(page).to have_content "The owls are faded"  
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

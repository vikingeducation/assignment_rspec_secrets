require 'rails_helper'

feature 'Actions as visitor' do
  let(:user){create(:user)}
  let(:secret){create(:secret, author: user )}
  before do
    secret
    visit root_path
  end

  context "viewing secrets" do
    scenario "successfully view page with a secret" do
      expect(page).to have_css('h1')
      expect(page).to have_content "Listing secrets"
      find_link('Show').visible?
    end
  end

  context "viewing specific secret - show" do
    scenario "successfully view page with a secret" do
      click_link('Show')
      expect(page).to have_content "Author"
      expect(page).to have_content "Body"
      expect(page).to have_content "Title"
    end
  end

  context "unable to create secrets" do
    scenario "login page appears" do
      click_link('New Secret')
      expect(page).to have_field("Password")
      expect(page).to have_field("Email")
      expect(page).to have_button("Log in")
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

  scenario "with improper name"  do
    fill_in('Name', :with => '1')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_button "Create User"
    expect(page).to have_content "Name is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper email" do
    fill_in('Name', :with => 'Sanskir')
    fill_in('Email', :with => 'gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_button "Create User"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper password" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'See')
    fill_in('Password confirmation', :with => 'See')
    click_button "Create User"
    expect(page).to have_content "Password is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with no password confirmation" do
    fill_in('Name', :with => 'Sanskit')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seewer')
    click_button "Create User"
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with some fields empty" do
    fill_in('Name', :with => 'Lukas')
    fill_in('Email', :with => '')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    click_button "Create User"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_field "Email"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with correct data" do
    fill_in('Name', :with => "Seek#{rand(123)}")
    fill_in('Email', :with => "Seek#{rand(123)}@gmail.com")
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')
    expect{ click_button "Create User" }.to change(User, :count).by(1)
    expect(page).to have_content "successfully"
    find_link('Logout').visible?
    sign_out
  end

end

feature 'Logging in to an account' do
  let(:user){create(:user)}
  before do
    user
    visit root_path
    click_link('Login')
  end

  scenario "with improper email" do
    fill_in('Email', :with => 'daria@dar.pl')
    fill_in('Password', :with => 'Seekrit')
    click_button "Log in"
    expect(page).to have_content("We couldn't sign you in")
    expect(page).to have_css ('div.alert')
  end

  scenario "with improper password" do
    fill_in('Email', :with => 'daria@dar.pl')
    fill_in('Password', :with => 'Seekrit')
    click_button "Log in"
    expect(page).to have_content("We couldn't sign you in")
    expect(page).to have_css ('div.alert')
  end

  scenario "with correct login data" do
    sign_in(user)
    expect(page).to have_content "Listing secrets"
    expect(page).to have_link("Logout")
    expect(page).not_to have_content "**"
  end

end

feature 'Creating secret as signed in user' do
  let(:user){create(:user)}
  before do
    user
    visit root_path
    sign_in(user)
    click_link "New Secret"
  end

  scenario "with improper title" do
    fill_in('Title', :with => '')
    fill_in('Body', :with => 'The owls are not what they seem. An amazing story catches every one involved in magic of this town.')
    click_button "Create Secret"
    expect(page).to have_content "Title is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper body" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => 'asd')
    click_button "Create Secret"
    expect(page).to have_content "Body is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with body missing" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => '')
    click_button "Create Secret"
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "successfull creation" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => 'The owls are not what they seem. An amazing story catches every one involved in magic of this town.')
    click_button "Create Secret"
    expect(page).to have_content "Secret was successfully created."
    expect(page).to have_css ('p#notice')
    expect(page).to have_content "The owls are faded"
  end

end




feature 'Editing secret as signed in user' do
  let(:user){create(:user)}
  let(:secret){create(:secret, author: user )}
  before do
    secret
    visit root_path
    sign_in(user)
    click_link "All Secrets"
    click_link "Edit"
  end

  scenario "with improper title" do
    fill_in('Title', :with => '')
    fill_in('Body', :with => 'The owls are not what they seem. An amazing story catches every one involved in magic of this town.')
    click_button "Update Secret"
    expect(page).to have_content "Title is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "with improper body" do
    fill_in('Title', :with => 'The owls are faded')
    fill_in('Body', :with => 'asd')
    click_button "Update Secret"
    expect(page).to have_content "Body is too short"
    expect(page).to have_css ('div#error_explanation')
  end

  scenario "Successfull Edit" do
    click_button "Update Secret"
    expect(page).to have_content "Secret was successfully updated."
    expect(page).to have_css ('p#notice')
  end

end


feature 'Deleting secret as signed in user' do
  let(:user){create(:user)}
  let(:user_one){create(:user)}
  let(:secret){create(:secret, author: user )}
  let(:secret_one){create(:secret, author: user_one )}
  before do
    secret
    secret_one
    visit root_path
    sign_in(user)
    click_link "All Secrets"
  end

  scenario "deleting own secret" do
    click_link "Destroy"
    expect(page).to have_content "Secret was successfully destroyed"
    expect(page).to have_css('div.alert')
  end

  scenario "unable to delete other's secret" do
    click_link "Destroy"
    expect(page).not_to have_link('Destroy')
  end

end

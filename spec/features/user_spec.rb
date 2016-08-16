require 'rails_helper'

feature 'User sign up' do
  let!(:user) { create(:user) }
  let!(:secret) { user.secrets.create(attributes_for(:secret)) }

  before do 
    visit new_user_path
  end

  specify "the user can click on the sign up link to get to a sign up form" do 

    name = "Foo"
    fill_in "Name", with: name
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    expect{ click_button "Create User" }.to change(User, :count).by(1)

    expect(page).to have_content "User was successfully created."
  end

  specify "an incomplete form re-renders the page" do 

    name = "Foo"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    expect{ click_button "Create User" }.to change(User, :count).by(0)

    expect(page).to have_css(".field_with_errors")
  end

end

feature 'User sign in' do 

  let(:user){ create(:user) }

  before do
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end

  specify "the user can sign in from the sign in path" do 
    expect(page).to have_content("Welcome, #{user.name}!")
  end

  specify "a signed in user can create a new secret" do
    click_on "New Secret"

    expect(page).to have_content("New secret")
  end
end
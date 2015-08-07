require 'rails_helper'

feature "Secret Viewing Not Signed In" do

  before do
    create(:secret)
    visit root_path
  end

  scenario "should see secrets" do
    expect(page).to have_content "Listing secrets"
  end 

  scenario "should not see the author unless signed in" do
    expect(page).to have_content "**hidden**"
  end

  scenario "should not see edit destroy links unless signed in" do
    expect(page).not_to have_content "Edit"
    expect(page).not_to have_content "Destroy"
  end

  scenario "should only show 5 secrets" do
    5.times {create(:secret)}
    visit current_path
    expect(page).to have_content("Show", {count: 5})
  end


end

feature "Signing Up" do

  before do
    create(:secret)
    visit users_path
  end

  scenario "there should be a sign up link" do
    expect(page).to have_content "New User"
  end

  scenario "user should be able to sign up" do
    click_link "New User"

    fill_in "Name", with: "Foo99"
    fill_in "Email", with: "Foo99@bar.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"

    expect{click_button "Create User"}.to change(User, :count).by(1)

    expect(current_path).to eql(user_path(User.second.id))

    expect(page).to have_content 'User was successfully created.'
  end



end
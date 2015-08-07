require 'rails_helper'

feature 'Visitor' do
  scenario "see secrets" do
    visit root_path
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "Title"

  end
end

feature 'User' do
  before do 
    visit users_path
  end

  scenario "can create a new user" do
    click_link "New User"

    name = "Bot"
    fill_in "Name", with: name
    email="bot@gmail.com"
    fill_in "Email", with: email

    fill_in "Password", with: "password" 
    fill_in "Password confirmation", with: "password" 

    expect{click_button "Create User"}.to change(User, :count).by(1)

    expect(page).to have_content "User was successfully created."
    expect(page).to have_content "Name: #{name}"
    expect(page).to have_content "Email: #{email}"
  end


  let(:user){ create(:user) }
  scenario "can login" do
    click_link "Login"
    
    
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    

    expect{click_button "Log in"}.to change(User, :count).by(0)

    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "New Secret"   
  end

  scenario "can logout" do
    sign_in(user)
    
    expect{click_link "Logout"}.to change(User, :count).by(0)   
    expect(page).to have_content "Login"
  end

end
feature 'User work with secrets' do
  let(:user){ create(:user) }
  let(:secret) { create(:secret) }
  before do 
    visit root_path
    sign_in(user)
  end

  scenario "create a secret" do
    click_link "New Secret"

    expect(page).to have_content "Title"
    fill_in "Title", with: "TitleSecret" 
    expect(page).to have_content "Body"
    fill_in "Body", with: "About Secret some text" 
    
    expect{click_button "Create Secret"}.to change(Secret, :count).by(1)   

    expect(page).to have_content "Author: #{user.name}"

  end

  scenario "edit a secret" do
    secret.author_id = user.id
    secret.save!
    visit root_path
    click_link "Edit"


    expect(page).to have_content "Title"
    expect(page).to have_content "Body"
    expect(page).to have_button "Update Secret"
  end 

  scenario "delete a secret" do
    secret.author_id = user.id
    secret.save!
    visit root_path
    # click_link "All Secrets"
    # save_and_open_page
    click_link "Destroy"

    expect{click_link "Destroy"}.to change(Secret, :count).by(-1)
    # expect(page).to have_content "Listing secrets"
    # expect(page).to have_content "Body"
    # expect(page).to have_button "Update Secret"
  end

  scenario "can't edit others secrets"

  scenario "can't delete others secrets"  

 
end




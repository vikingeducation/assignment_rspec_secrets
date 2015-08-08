require 'rails_helper'

feature 'Visitor' do
  let(:secret){create(:secret)}
  let(:user){create(:user)}
  before do 
    visit root_path
  end

  scenario "see secrets" do
    click_link "All Secrets"
    expect(page).to have_content "Listing secrets"
    expect(page).to have_content "Title"
  end

  scenario "Can't see authors" do
    secret
    click_link "All Secrets"
    
    expect(page).to have_content "**hidden**"
  end

  scenario "see secret with hidden author" do
    secret
    visit root_path
    click_link "Show"
    expect(page).to have_content "Author: **hidden**"
  end

  scenario "redirect to login if tries to edit a user" do
    user
    click_link "All Users"
    expect(page).to have_content "#{user.name}"
    click_link "Edit"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
  end

  scenario "redirect to login if tries to create a secret" do
    secret
    click_link "All Secrets"
    click_link "New Secret"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
  end

end

feature 'User' do
  let(:user){ create(:user) }
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

  scenario "can edit self info" do
    sign_in(user)
    click_link "#{user.name}"
    expect(page).to have_content "Name: #{user.name}"
    expect(page).to have_content "Email: #{user.email}"

    click_link "Edit"
    expect(page).to have_content "Password"
    fill_in "Name", with: user.name+"New"
  
    click_button "Update User"
    expect(page).to have_content "User was successfully updated."
  end


end


feature 'User work with secrets' do
  let!(:user){ create(:user) }
  let!(:secret) { create(:secret) }

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
   
    expect(page).to have_content "#{secret.title}"
   
    expect{click_link "Destroy"}.to change(Secret, :count).by(-1)

    expect(page).to_not have_content "Destroy"
  end

  scenario "can't edit others secrets" do 
    expect(page).to have_content "#{secret.title}"
    expect(page).to have_content "Show"
   
    click_link "Show"

    expect(page).to_not have_content "Edit"

  end

  scenario "can't delete others secrets"  do
    expect(page).to have_content "#{secret.title}"
    expect(page).to have_content "Show"
    expect(page).to_not have_content "Destroy"
  end

  scenario "can't see authors if not loged in"  do

  end

end




require 'rails_helper'

feature 'viewing secrets' do
  before do
    visit root_path
  end
  
  scenario 'visitor first brought to secrets index' do
    expect(page).to have_content('Listing secrets')
  end

  scenario 'visitor clicks secrets link from another page' do
    click_link("All Users")
    click_link("All Secrets")
    expect(page).to have_content('Listing secrets')
  end
end

feature 'creating user accounts' do
  before do
    visit root_path
  end

  scenario 'visitor signs up' do
    sign_up
    expect{ click_button "Create User" }.to change(User, :count).by(1)
    expect(page).to have_content('User was successfully created.')
  end

  scenario 'visitor cannot sign up with email that has already been used' do
    sign_up
    click_button("Create User")
    sign_up
    expect{ click_button "Create User"}.not_to change(User, :count)
    expect(page).to have_content('Email has already been taken')
  end

  scenario 'visiting cannot sign up with incorrect password confirmation' do
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "123456789")
    expect{ click_button "Create User"}.not_to change(User, :count)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end

feature 'using user accounts' do

  before do
    visit root_path
    sign_up
    click_button("Create User")
    click_link("Logout")
  end

  scenario 'not-signed-in user can sign in' do
    expect(page).to have_content("Login")
    sign_in
    expect(page).to have_content("Welcome, Foo!")
    expect(page).to have_content("Logout")
    expect(page).to have_content("Listing secrets")
  end

  scenario 'user cannot sign in with incorrect password' do
    click_link("Login")
    fill_in("Email", :with => "foo@email.com")
    fill_in("Password", :with => "123456789")
    click_button ("Log in")
    expect(current_path).to eq('/session')
  end

  scenario 'signed in user can create a secret' do
    sign_in
    expect(page).to have_content("New Secret")
    click_link("New Secret")
    expect(page).to have_content("New secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    expect{ click_button("Create Secret")}.to change(Secret, :count).by(1)
    expect(page).to have_content("Secret was successfully created.")
    expect(page).to have_content("Secret title")
    expect(page).to have_content("Secret body")
    expect(page).to have_content("Foo")
  end

  scenario 'secret cannot be created with blank body' do
    sign_in
    click_link("New Secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "")
    expect{ click_button("Create Secret")}.not_to change(Secret, :count)
    expect(page).to have_content("Body can't be blank")
    expect(current_path).to eq('/secrets')
  end

  scenario 'secret cannot be created with blank title' do
    sign_in
    click_link("New Secret")
    fill_in("Title", :with => "")
    fill_in("Body", :with => "Secret body")
    expect{ click_button("Create Secret")}.not_to change(Secret, :count)
    expect(page).to have_content("Title can't be blank")
    expect(current_path).to eq('/secrets')
  end

  scenario 'non-signed-in user cannot create a secret' do
    click_link("New Secret")
    expect(current_path).to eq('/session/new')
  end

  scenario 'signed-in user can edit their secret' do
    sign_in
    expect(page).to have_content("New Secret")
    click_link("New Secret")
    expect(page).to have_content("New secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    click_button("Create Secret")
    click_link("Edit")
    fill_in("Title", :with => "Edited title")
    click_button("Update Secret")
    expect(page).to have_content("Edited title")
  end

  scenario 'signed-in user cannot edit other users secrets' do
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo2@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "12345678")
    click_button("Create User")
    click_link("All Secrets")
    click_link("New Secret")
    expect(page).to have_content("New secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    click_button("Create Secret")
    click_link("Logout")
    sign_up
    click_button("Create User")
    click_link("All Secrets")
    expect(page).to_not have_content("Edit")
    click_link("Show")
    expect(page).to_not have_content("Edit")
  end


  scenario 'non-signed-in user cannot edit secrets' do
    sign_in
    expect(page).to have_content("New Secret")
    click_link("New Secret")
    expect(page).to have_content("New secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    click_button("Create Secret")
    click_link("Logout")
    visit(edit_secret_path(1))
    expect(current_path).to eq('/session/new')
  end

  scenario 'signed-in user can delete their own secrets' do
    sign_in
    click_link("New Secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    click_button("Create Secret")
    click_link("All Secrets")
    expect{ click_link("Destroy") }.to change(Secret, :count).from(1).to(0)
    expect(current_path).to eq('/secrets')
  end

  scenario 'signed-in user cannot delete other users\' secrets' do
    click_link("All Users")
    click_link("New User")
    fill_in("Name", :with => "Foo")
    fill_in("Email", :with => "foo2@email.com")
    fill_in("Password", :with => "12345678")
    fill_in("Password confirmation", :with => "12345678")
    click_button("Create User")
    click_link("All Secrets")
    click_link("New Secret")
    expect(page).to have_content("New secret")
    fill_in("Title", :with => "Secret title")
    fill_in("Body", :with => "Secret body")
    click_button("Create Secret")
    click_link("Logout")
    sign_up
    click_button("Create User")
    click_link("All Secrets")
    expect(page).to_not have_content("Destroy")
    click_link("Show")
    expect(page).to_not have_content("Destroy")
  end



end













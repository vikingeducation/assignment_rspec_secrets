require 'rails_helper'



feature 'Secrets' do
  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    visit root_path
  end
  let(:author) { build(:author) }
  let(:secret) { create(:secret) }

  scenario "view all secrets as a visitor" do
    author.secrets << create_list(:secret, 10)
    author.save!
    visit root_path
    expect(page).to have_content "Secret Body"
  end

  scenario "sign up as a visitor" do
    click_link 'All Users'
    click_link 'New User'
    fill_in_signup(author)
    expect(page).to have_content('User was successfully created')
  end

  scenario "As a not-signed-in user, I want to sign in to my account" do
    author.save!
    sign_in(author)
    expect(page).to have_content("Welcome, #{author.name}!")
  end

  scenario "As a signed-in user, be able to create a secret" do
    author.save
    sign_in(author)
    click_link("New Secret")
    fill_in "Title", with: secret.title
    fill_in "Body", with: secret.body
    click_button('Create Secret')
    expect(page).to have_content('Secret was successfully created.')
  end

  scenario "As a signed-in user, be able to edit one of my secrets" do
    author.save
    sign_in(author)
    click_link("New Secret")
    fill_in "Title", with: secret.title
    fill_in "Body", with: secret.body
    click_button('Create Secret')
    visit root_path
    click_link "Edit"
    fill_in "Title", with: "Edited Title"
    fill_in "Body", with: "Edited Body"
    click_button("Update Secret")
    expect(page).to have_content('Secret was successfully updated.')
  end


  scenario "As a signed-in user, be able to delete one of my secret" do
    author.save
    sign_in(author)
    click_link("New Secret")
    fill_in "Title", with: secret.title
    fill_in "Body", with: secret.body
    click_button('Create Secret')
    visit root_path
    click_link "Destroy"
    page.accept_confirm do
      click_button "OK"
    end
    expect(page).to have_no_content(secret.body)
  end

end

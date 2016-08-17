require 'rails_helper'



feature 'Secrets' do
  before do
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
    fill_in_signup(author)
    expect(page).to have_content('User was successfully created')
  end



  scenario "As a not-signed-in user, I want to sign in to my account" do
    author.save!
    sign_in(author)
    expect(page).to have_content("Welcome, #{author.name}!")
  end

  context 'as a signed-in user' do

    before do
      author.save
      sign_in(author)
      click_link("New Secret")
    end

    scenario "be able to create a secret" do
      fill_in_secret(secret)
      expect(page).to have_content('Secret was successfully created.')
    end

    scenario "without a secret, does not have option to delete secrets" do
      visit root_path

      expect(page).not_to have_link('Destroy')
    end

    context 'with a secret' do

      before do
        fill_in_secret(secret)
        visit root_path
      end

      scenario "be able to edit one of my secrets" do
        fill_in_edit
        expect(page).to have_content('Secret was successfully updated.')
      end

      scenario "be able to delete one of my secret" do
        click_link "Destroy"
        expect(page).to have_no_content("toodloo")
      end

    end
  end

end

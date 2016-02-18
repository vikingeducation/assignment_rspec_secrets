require 'rails_helper.rb'

feature 'Authentication' do

  let(:user){ build(:user) }
  let(:wrong_password) { build(:user, :wrong_password) }
  let(:wrong_email) { build(:user, :wrong_email) }


  before do
    visit root_path
  end

  scenario "as visitor can sign up and logs them in" do
    click_on('All Users')
    click_on('New User')
    fill_in('Name', with: 'Harry')
    fill_in('Email', with: 'harry@potter.com')
    fill_in('Password', with: 'qwerqwer')
    fill_in('Password confirmation', with: 'qwerqwer')
    click_on('Create User')
    expect(page).to have_content 'User was successfully created.'
    expect(page).to have_content 'harry'
    expect(page).to have_content 'harry@potter.com'
    expect(page).to have_content 'Logout'
  end

  context "with improper credentials" do

    before do
      wrong_email.save!
      sign_in
    end


    scenario "does not allow sign in" do
      expect(page).to have_content "Login"
    end
  end

  context "with proper credentials" do
    before do
      user.save!
      sign_in
    end
    scenario "successfully signs in an existing user" do
      # verify we're on the user's show page now
      expect(page).to have_content "Logout"
    end

    context "after signing out" do
      before do
        sign_out
      end
      scenario 'signs out the user' do
        expect(page).to have_content 'Login'
      end
    end

    context 'shows secret on login' do
      before do
        user.save!
        sign_in
        secret
      end

      scenario 'shows secret info on show page' do
        expect(page).to have_content 'Secret was successfully created.'
        expect(page).to have_content 'Secret T'
        expect(page).to have_content 'Secret B'
      end

      scenario 'shows logged in secret info on index page' do
        click_on('Back')
        within_table('') do
          expect(page).to have_content 'Edit'
          expect(page).to have_content 'Destroy'
          expect(page).to_not have_content '**hidden**'
          expect(page).to have_content 'foobar'
        end
      end

      scenario 'displays secret information on index' do
        click_on('Back')
        expect(page).to have_content 'Secret T'
        expect(page).to have_content 'Secret B'
      end

      scenario 'clicking edit shows edit forms' do
        click_on('Edit')
        expect(find_field('Title').value).to eq('Secret T')
        expect(find_field('Body').value).to eq('Secret B')
        expect(page).to have_content 'Editing secret'
      end

      scenario 'submitting user edit works' do
        click_on('Edit')
        fill_in('Title', with: 'UPDATE CHECK')
        fill_in('Body', with: 'HELLO')
        click_on('Update Secret')
        expect(page).to have_content 'Secret was successfully updated.'
        expect(page).to have_content 'UPDATE CHECK'
        expect(page).to have_content 'HELLO'
      end

      scenario 'deleting users secret works', js: true do
        click_on('Back')
        click_on('Destroy')
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content 'Secret T'
        expect(page).to_not have_content 'Secret B'
      end
    end


  end
end

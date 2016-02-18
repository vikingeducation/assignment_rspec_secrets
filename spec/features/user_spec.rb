require 'rails_helper.rb'

feature 'Authentication' do

  let(:user){ build(:user) }
  let(:wrong_password) { build(:user, :wrong_password) }
  let(:wrong_email) { build(:user, :wrong_email) }


  before do
    visit new_session_path
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
    end


  end
end

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
      user.email = user.email + "x"
      wrong_email.create
      sign_in(user)
    end


    scenario "does not allow sign in" do
      expect(page).to have_content "We couldn't sign you in"
    end
  end

  context "with proper credentials" do
    before do
      sign_in(user)
    end
    scenario "successfully signs in an existing user" do
      # verify we're on the user's show page now
      expect(page).to have_content "You've successfully signed in"
    end

    context "after signing out" do
      before do
        sign_out
      end
      scenario "signs out the user" do
        expect(page).to have_content "You've successfully signed out"
      end
    end
  end
end

require 'rails_helper'

RSpec.feature 'UserLogins', type: :feature do

  before do
    user_pw= 'TallyHoe'
    @user = create :user, name: 'Sally Forthe',
                   password: user_pw, password_confirmation: user_pw
  end

  feature 'User logging into account' do
    scenario 'Using correct credentials' do
      sign_in @user

      expect(current_path).to eq root_path
      expect(page).to have_content "Welcome, #{@user.name}!"
    end

    scenario 'Using incorrect credentials' do
      @user.email = 'sforthe'
      sign_in @user

      expect(current_path).to eq session_path
      expect(page).not_to have_content "Welcome, #{@user.name}!"
    end
  end
end

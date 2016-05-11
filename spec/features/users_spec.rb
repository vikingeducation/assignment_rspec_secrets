require 'rails_helper'

describe 'Users' do
  # --------------------------------------------
  # Login
  # --------------------------------------------
  feature 'login' do
    let!(:user){create(:user)}

    before do
      visit new_session_path
    end

    scenario 'succeeds with valid credentials' do
      sign_in(user)
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    scenario 'fails with invalid credentials' do
      sign_in(build(
        :user,
        :email => 'asdf@asdf.com',
        :password => 'asdf'
      ))
      expect(page).to have_content('Login')
    end
  end

  # --------------------------------------------
  # Signup
  # --------------------------------------------
  feature 'signup' do
    let(:user){build(:user)}
    let(:error){error_text_for(user)}

    before do
      visit new_user_path
    end

    scenario 'succeeds with valid user data' do
      signup(user, user.password)
      expect(page).to have_content(success_text_for(user, 'create'))
    end

    scenario 'fails with invalid name' do
      user.name = ''
      signup(user, user.password)
      expect(page).to have_content(error)
    end

    scenario 'fails with invalid email' do
      user.email = ''
      signup(user, user.password)
      expect(page).to have_content(error)
    end

    scenario 'fails with invalid password' do
      signup(user, '')
      expect(page).to have_content(error)
    end

    scenario 'fails with invalid password confirmation' do
      signup(user, user.password, 'asdf')
      expect(page).to have_content(error)
    end
  end

  # --------------------------------------------
  # Show User
  # --------------------------------------------
  feature 'account viewing' do
    let!(:user){create(:user)}

    scenario 'succeeds when user is logged in' do
      visit new_session_path
      sign_in(user)
      visit user_path(user)
      expect(page).to have_content("Name: #{user.name}")
    end

    scenario 'fails when user is not logged in' do
      visit user_path(user)
      expect(page).to_not have_content("Name: #{user.name}")
    end
  end

  # --------------------------------------------
  # Edit User
  # --------------------------------------------
  feature 'account editing' do
    let!(:user){create(:user)}

    scenario 'is possible when a user is logged in' do
      visit new_session_path
      sign_in(user)
      visit edit_user_path(user)
      expect(page).to have_content("Editing user")
    end

    scenario 'is not possible when a user is logged out' do
      visit edit_user_path(user)
      expect(page).to_not have_content("Editing user")
    end
  end

  # --------------------------------------------
  # Delete User
  # --------------------------------------------
  feature 'account deletion' do
    let!(:user){create(:user)}

    context 'when the user is logged in' do
      scenario 'is possible if the user is the user being destroyed' do
        visit new_session_path
        sign_in(user)
        visit users_path
        click_destroy(user)
        expect(page).to have_content('Login')
      end

      scenario 'is not possible if the user is not the user being destroyed' do
        another_user = create(:user)
        visit new_session_path
        sign_in(another_user)
        visit users_path
        click_destroy(another_user)
        expect(page).to_not have_content('Listing users')
      end
    end

    scenario 'is not possible when a user is logged out' do
      visit users_path
      click_destroy(user)
      expect(page).to_not have_content('Listing users')
    end
  end
end






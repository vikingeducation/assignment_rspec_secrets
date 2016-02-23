require 'rails_helper'

# How to think about breaking up into separate files and features/contexts/etc.?
feature 'Users' do

  let (:user){ create(:user) }

  before do
    create_list(:secret, 25)
    visit root_path
  end

  context 'without sign-in' do
    scenario 'allows viewing of last five secrets' do
      expect(page).to have_content("**hidden**", count: 5)
    end

    scenario 'does not allow creation of a secret' do
      click_link 'New Secret'
      expect(page).to have_content "Not authorized, please sign in!"
    end

    scenario 'does not allow editing a secret' do
      visit edit_secret_path(Secret.last)
      expect(page).to have_content "Not authorized, please sign in!"
    end

    # No need to test things like purposely going around security (this is more of a controller test)
    # scenario 'does not allow deleting a secret' do
    #   page.driver.submit :delete, "/secrets/#{Secret.last.id}", {}
    #   expect(page).to have_content "Not authorized, please sign in!"
    # end

    scenario 'allows sign up' do
      click_link 'All Users'
      click_link 'New User'

      fill_in 'Name', with: 'Foo'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Create User'

      expect(page).to have_content "User was successfully created."
      expect(page).to have_content "Foo"
    end
  end

  context 'with improper credentials' do
    before do
      user.email += "x"
      sign_in(user)
    end

    scenario 'does not allow sign in' do
      expect(page).to have_content "We couldn't sign you in"
    end
  end

  context 'with proper credentials' do
    before do
      sign_in(user)
    end

    scenario 'allows sign in' do
      expect(page).to have_content "You've successfully signed in"
    end

    scenario 'signs me out' do
      sign_out
      expect(page).to have_content "You've successfully signed out"
    end

    context 'allows secret' do
      before do
        click_link 'New Secret'
        fill_in 'Title', with: 'Lorem'
        fill_in 'Body', with: "Ipsum"
        click_button 'Create Secret'
      end

      scenario 'creation' do
        expect(page).to have_content "Secret was successfully created."

        # Should I put these only in controller/view tests?
        expect(page).to have_content "Lorem"
        expect(page).to have_content "Ipsum"
        expect(page).to have_content user.name
      end

      scenario 'editing' do
        click_link 'Edit'
        fill_in 'Title', with: 'Another title'
        click_button 'Update Secret'

        expect(page).to have_content "Secret was successfully updated."
      end

      scenario 'deleting' do
        visit root_path
        click_link 'Destroy'

        expect(page).to have_content "Secret was successfully destroyed."
      end
    end
  end
end

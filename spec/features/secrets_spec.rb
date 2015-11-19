require 'rails_helper'

feature 'Secrets' do
  let!(:user){create(:user)}
  let!(:secrets){create_list(:secret, 5, :author => user)}
  let!(:user_one){create(:user, :name => 'User One', :email => 'user@one.com')}
  let!(:user_two){create(:user, :name => 'User Two', :email => 'user@two.com')}
  let!(:secrets_user_one){create_list(:secret, 5, :author => user_one)}
  let!(:secrets_user_two){create_list(:secret, 5, :author => user_two)}

  # ----------------------------------------
  # View Secrets Index
  # ----------------------------------------
  feature 'listing' do
    context 'when the user is logged in' do
      before do
        visit new_session_path
        sign_in(user_one)
        visit secrets_path
      end

      scenario 'shows the author of all secrets' do
        expect(secrets_listing_author_hidden?).to eq(false)
      end

      scenario 'shows edit links for current user secrets' do
        expect(secrets_listing_has_action_links_for?(user_one, 'edit')).to eq(true)
      end

      scenario 'shows destroy links for current user secrets' do
        expect(secrets_listing_has_action_links_for?(user_one, 'destroy')).to eq(true)
      end
    end

    context 'when the user is logged out' do
      before do
        visit secrets_path
      end

      scenario 'hides the author of all secrets' do
        expect(secrets_listing_author_hidden?).to eq(true)
      end

      scenario 'has no edit links' do
        #
        expect(secrets_listing_has_edit_links?).to eq(false)
      end

      scenario 'has no destroy links' do
        expect(secrets_listing_has_destroy_links?).to eq(false)
      end
    end
  end

  # ----------------------------------------
  # Create Secret
  # ----------------------------------------
  feature 'creation' do
    context 'when the user is logged in' do
      scenario 'redirects with a success message' do
        visit new_session_path
        sign_in(user)
        visit new_secret_path
        fill_in('Title', :with => 'My secret')
        fill_in('Body', :with => 'My secret body')
        submit_form
        expect(page).to have_content(success_text_for('Secret', 'create'))
      end
    end

    context 'when the user is logged out' do
      scenario 'redirects to the login page' do
        visit new_secret_path
        expect(page).to have_content('Login')
      end
    end
  end

  # ----------------------------------------
  # Show Secret
  # ----------------------------------------
  feature 'individual show page' do
    context 'when the user is logged in' do
      scenario 'shows the author' do
        visit new_secret_path
        sign_in(user)
        visit secret_path(secrets.first)
        expect(page).to_not have_content(hidden_text)
      end
    end

    context 'when the user is logged out' do
      scenario 'hides the author' do
        visit secret_path(secrets.first)
        expect(page).to have_content(hidden_text)
      end
    end
  end

  # ----------------------------------------
  # Edit Secret
  # ----------------------------------------
  feature 'editing' do
    context 'when the user is logged in' do
      before do
        visit new_session_path
        sign_in(user)
        visit edit_secret_path(secrets.first)
      end

      scenario 'is enabled on current user secrets' do
        expect(page).to have_content('Editing secret')
      end

      scenario 'redirects with a success message when successful' do
        submit_form
        expect(page).to have_content(success_text_for('Secret', 'update'))
      end

      scenario 'displays an error message when fails' do
        fill_in('Title', :with => '')
        submit_form
        expect(page).to have_content(error_text_for('Secret'))
      end
    end

    context 'when the user logged out' do
      scenario 'redirects to the login page' do
        visit edit_secret_path(secrets.first)
        expect(page).to have_content('Login')
      end
    end
  end

  # ----------------------------------------
  # Delete Secret
  # ----------------------------------------
  feature 'deletion' do
    context 'when the user is logged in' do
      before do
        visit new_session_path
        sign_in(user)
        visit secrets_path
      end

      after do
        visit logout_path
      end

      scenario 'is enabled on current user secrets', :js => true do
        link = find('a', :text => 'Destroy', :match => :first)
        link.click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content(success_text_for('Secret', 'destroy'))
      end

      scenario 'redirects to secrets listing upon deletion', :js => true do
        link = find('a', :text => 'Destroy', :match => :first)
        link.click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content('Listing secrets')
      end
    end

    context 'when the user is logged out' do
      scenario 'is not enabled for any secrets' do
        visit secrets_path
        expect {find('a', :text => 'Destroy')}.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end










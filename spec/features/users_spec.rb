require 'rails_helper'

feature 'View all secrets as visitor' do
  before do
    secrets = create_list(:secret, 10)
  end

  scenario 'contains table of secrets' do
    visit(secrets_path)
    expect(page).to have_selector('table tbody tr td')
  end

  scenario 'displays body of secret' do
    visit(secrets_path)
    expect(page).to have_content('super dope body')
  end

  scenario 'displays title of secret' do
    visit(secrets_path)
    expect(page).to have_content('super dope title')
  end

  scenario 'displays hidden author' do
    visit(secrets_path)
    expect(page).to have_content('**hidden**')
  end

  scenario 'displays link to secret show pages' do
    secret = Secret.last
    visit(secrets_path)
    first(:link, 'Show').click
    expect(current_path).to eq(secret_path(secret))
  end
end

feature 'Sign up as visitor' do
  scenario 'navigate to sign up page' do 
    visit(root_path)
    click_link('All Users')
    find_link('New User').click
    expect(current_path).to eq(new_user_path)
  end

  scenario 'displays errors when empty form submitted' do
    visit(new_user_path)
    click_button('Create User')
    expect(page).to have_content('4 errors prohibited this user from being saved:')
  end

  scenario 'creates user successfully' do
    visit(new_user_path)
    fill_in 'Name', with: 'name'
    fill_in 'Email', with: 'name@name.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_button("Create User")
    expect(page).to have_content("User was successfully created.")
  end
end

feature 'Sign in' do
  let(:user){ create(:user) }
  scenario 'Sign in successfully' do
    sign_in(user)
    expect(page).to have_content("Welcome, #{user.name}")
  end

  scenario 'Renders login when wrong ' do
    visit(new_session_path)
    fill_in "Email", with: ''
    fill_in "Password", with: ''
    click_button('Log in')
    expect(current_path).to eq(session_path)
  end
end

feature 'Create a Secret' do
  let(:user){ create(:user) }

  context 'User signs in' do
    before do
      sign_in(user)
    end

    scenario 'successfully creates a secret' do
      visit(root_path)
      click_link('New Secret')
      fill_in 'Title', with: 'title'
      fill_in 'Body', with: 'body'
      click_button('Create Secret')
      expect(page).to have_content('Secret was successfully created.')
    end

    scenario 'display errors when form is empty' do
      visit(new_secret_path)
      click_button('Create Secret')
      expect(page).to have_content('4 errors prohibited this secret from being saved:')
    end
  end

  context 'User not signed in' do
    scenario 'cannot access new secret form' do
      visit(root_path)
      click_link("New Secret")
      expect(current_path).to eq(new_session_path)
    end
  end

end

feature 'Edit a Secret' do
  let(:user){ create(:user) }

  context 'Signed in user creates secret' do 
    before do
      sign_in(user)
      signed_in_user_creates_secret
      visit(root_path)
      click_link('Edit')
    end

    scenario 'access edit form' do
      expect(page).to have_content('Editing secret')
    end

    scenario 'successfully edit a secret' do
      fill_in 'Title', with: 'New Title'
      fill_in 'Body', with: 'New Body'
      click_button('Update Secret')
      expect(page).to have_content('Secret was successfully updated.')
    end

    scenario 'display errors when invalid content submitted' do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_button('Update Secret')
      expect(page).to have_content('4 errors prohibited this secret from being saved:')
    end
  end

  context "Signed in user with no secrets" do
    before do
      sign_in(user)
    end

    scenario "can't edit other people's secrets" do
      create_list(:secret, 10)
      visit(secrets_path)
      expect(page).not_to have_content('Edit')
    end
  end
end

feature 'Delete a Secret' do
  let(:user){ create(:user) }

  context 'Signed in user creates secret' do 
    before do
      sign_in(user)
      signed_in_user_creates_secret
      visit(root_path)
    end

    scenario 'access delete link' do
      expect(page).to have_content('Destroy')
    end

    scenario 'successfully deletes link' do
      expect{ click_link('Destroy') }.to change{ Secret.count }.by(-1)
    end
  end


  context 'Signed in user has no secrets' do
    before do
      sign_in(user)
    end

    scenario "can't delete other people's secrets" do
      create_list(:secret, 10)
      visit(secrets_path)
      expect(page).not_to have_content('Destroy')
    end
  end

end




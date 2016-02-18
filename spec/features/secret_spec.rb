require 'rails_helper'



feature 'view secrets as a visitor' do

  let(:secret){ create(:secret) }
  
  scenario 'secrets table is visible' do
    visit root_path

    expect(page).to have_css('body > table > thead > tr > th')
    expect(page).to have_content('Title')
    expect(page).to have_content('Body')
    expect(page).to have_content('Author')
  end

  scenario 'individual secrets are viewable' do
    secret
    visit root_path
    click_link('Show')

    expect(page).to have_content(secret.title)
    expect(page).to have_content(secret.body)

    expect(page).to have_link('Back', secrets_path)

  end

  scenario 'user can not edit or delete secrets' do
    secret
    visit root_path

    expect(page).to_not have_link('Edit', :href => edit_secret_path(secret))
    expect(page).to_not have_link('Delete', :href => secret_path(secret))
  end

end




feature 'creating a new secret' do

  let(:user){ create(:user, :email => 'foo0@bar.com', :password => 'foobar') }
  
  scenario 'logged in user can create a new secret' do
    user
    log_in(user)
    click_on('All Secrets')
    click_on('New Secret')

    fill_in('Title', :with => 'Secret1')
    fill_in('Body', :with => 'This is a secret body.')

    click_on('Create Secret')

     expect(page).to have_content('Secret was successfully created.')
  end
end

feature 'editing a secret' do

  let(:secret){ create(:secret) }

  scenario 'logged in user can edit their secrets' do
    secret
    log_in(secret.author)

    visit edit_secret_path(secret)
    fill_in('Body', :with => 'This is an edited secret body.')
    click_on('Update Secret')

     expect(page).to have_content('Secret was successfully updated.')

     expect(page).to have_content('This is an edited secret body.')
    end

  scenario 'logged in user cannot add invalid body and title' do
    secret
    log_in(secret.author)

    visit edit_secret_path(secret)
    fill_in('Title', :with => 'title'*5)
    fill_in('Body', :with => 'hi')
    click_on('Update Secret')

    expect(page).to have_content('Title is too long ')
    expect(page).to have_content('Body is too short ')
  end

  end

feature 'deleting a secret' do

  let(:secret){ create(:secret) }

  scenario 'logged in user can delete their secrets' do
    secret
    log_in(secret.author)

    visit secrets_path
    
    click_on('Destroy')

     expect(page).to_not have_content(secret.title)
     expect(page).to_not have_content(secret.body)
    
  end

end




















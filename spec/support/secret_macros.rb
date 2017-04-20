module SecretMacros
  def create_valid_secret
    visit root_path
    click_link "New Secret"
    within('.new_secret') do
      fill_in  'Title', with: 'New Title'
      fill_in  'Body', with: 'Lorem ipsum dolor.'
    end
  end

  def create_invalid_secret
    visit root_path
    click_link "New Secret"
    within('.new_secret') do
      fill_in  'Title', with: 'Ne'
      fill_in  'Body', with: 'Bla'
    end
    click_button "Create Secret"
  end

  def create_secret_for(user)
    user.secrets.create(title: 'Some title', body: 'Some body')
  end


end

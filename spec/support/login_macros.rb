module LoginMacros
  def sign_in(user)
    visit(new_session_path)
    fill_in "Email", with: "#{user.email}"
    fill_in 'Password', with: "foobar"
    click_button('Log in')
  end

  def signed_in_user_creates_secret
    visit(root_path)
    click_link('New Secret')
    fill_in 'Title', with: 'secret title'
    fill_in 'Body', with: 'secret body'
    click_button('Create Secret')
  end
end
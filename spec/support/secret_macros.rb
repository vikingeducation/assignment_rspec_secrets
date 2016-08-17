module SecretMacros
  def create_secret
    click_link "New Secret"
    fill_in "Title", with: "Secret title"
    fill_in "Body", with: "Secret body"
    click_button "Create Secret"
  end
end
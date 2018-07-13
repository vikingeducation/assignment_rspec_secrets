module CreateSecretMacros

  def create_secret_for(user)
    new_secret = create(:secret, author: user)
    visit root_path
  end 

end

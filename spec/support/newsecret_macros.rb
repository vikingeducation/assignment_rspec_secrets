module NewSecretMacros

  def new_secret(user)
    sign_in(user)
    click_link "New Secret"

    fill_in "Title", with: "New mission"
    fill_in "Body", with: "Save the world"
    expect{click_button "Create Secret"}.to change(Secret, :count).by(1)

  end

end
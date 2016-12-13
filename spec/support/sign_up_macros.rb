module SignupMacros
  def go_to_sign_up_page
    visit root_path

    click_link 'All Users'
    click_link 'New User'
  end
end

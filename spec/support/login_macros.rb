module LoginMacros


	def sign_in(user)
		visit new_session_path
		fill_in('email', with: user.email)
		fill_in('password', with: 'password')
		click_button('Log in')
	end


end
require 'rails_helper'

feature 'User' do

	before do
		
		# We'll want to create some secrets to display and 
		# go to the root path.
		create_list(:secret, 25)
		visit(root_path)

	end

	# Non logged-in users should be able to view all secrets
	context 'viewing secrets' do
		
		let(:user){ build(:user) }
		let(:secret){ build(:secret) }

		scenario 'wants to view all secrets' do
			
			# Remember, the secret#index page uses the last_five method
			# in the controller to show the number of posts.
			expect(page).to have_css('tbody > tr', count: 5.to_i)

			# and Secret.count should equal 25 like we built above.
			expect(Secret.count).to eq(25)
		end

	end # /secnario not logged-in

	# They can create new users as well.
	context 'creates a new User' do
		
		scenario 'with valid credentials' do
			visit(new_user_path)
			fill_in('user_name', with: 'Johnny Quest')
			fill_in('user_email', with: 'test@aol.com')
			fill_in('user_password', with: 'password')
			fill_in('user_password_confirmation', with: 'password')
			expect{ click_button('Create User') }.to change(User, :count).by(1)
			expect(page).to have_content 'User was successfully created'
		end

		# This is a failing test
		scenario 'without an email'	do
			visit(new_user_path)
			fill_in('user_name', with: 'Johnny Quest')
			fill_in('user_password', with: 'password')
			fill_in('user_password_confirmation', with: 'password')
			expect{ click_button('Create User') }.to_not change(User, :count)
			expect(page).to have_content "Email can't be blank"
		end

		# This is a failing test
		scenario 'without a name' do
			visit(new_user_path)
			fill_in('user_email', with: 'test@aol.com')
			fill_in('user_password', with: 'password')
			fill_in('user_password_confirmation', with: 'password')
			expect{ click_button('Create User') }.to_not change(User, :count)
			expect(page).to have_content "Name can't be blank"
		end

		# This is a failing test
		scenario 'with mismatched passwords'	do
			visit(new_user_path)
			fill_in('user_email', with: 'test@aol.com')
			fill_in('user_name', with: 'Johnny Quest')
			fill_in('user_password', with: 'password')
			fill_in('user_password_confirmation', with: 'password2')
			expect{ click_button('Create User') }.to_not change(User, :count)
			expect(page).to have_content "Password confirmation doesn't match Password"
		end

	end # /context creates a User

	context 'logs in' do

		let(:user){ create(:user, :email => 'test1@aol.com', :password => 'password', :password_confirmation => 'password') }
		
		before do
			visit(new_session_path)
		end

		scenario 'as a valid user' do
			sign_in(user)
			# If the page has 'New Secret' then the user successfully logged in.
			expect(page).to have_content "New Secret"
		end

		scenario 'as an invalid user' do
			user = User.create(:password_confirmation => 'password2')
			sign_in(user)
			# This means the user didn't login properly
			expect(page).to_not have_content "New Secret"
		end

	end # /context logs in

end
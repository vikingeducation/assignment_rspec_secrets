require 'rails_helper'

describe 'secrets/index.html.erb' do
	
	context 'unauthorized user' do

		# TODO: Can definitely refactor these into 
		# macros or something similar in the future.
		# DUP: 1
		before :each do
			def view.signed_in_user?
				false
			end

			def view.current_user
				nil
			end
		end

		it 'unauthorized user cannot view author names' do
			secrets = create_list(:secret, 5)
			assign(:secrets, secrets)

			render
			expect(rendered).to match('<td>\*\*hidden\*\*</td>')
		end

	end # /context unauthorized user

	context 'authorized user' do

		let(:user){ create(:user) }

		# DUP: 1
		before :each do
			def view.signed_in_user?
				true
			end

			@user = user
			def view.current_user
				@user
			end
		end

		it 'authorized user can view author names' do
			secrets = create_list(:secret, 5)
			assign(:secrets, secrets)
			render
			expect(rendered).to match(user.name)
		end

	end # /context authorized user

end


# NOTE: This was weird, it was literally only looking in index.html.erb NOT the partials...
describe 'shared/_navigation.html.erb' do

	context 'authorized user' do
		let(:user){ create(:user) }

		# DUP: 1
		before :each do
			def view.signed_in_user?
				true
			end

			@user = user
			def view.current_user
				@user
			end
		end

		it 'shows a logout link for a logged in user' do
			secret = create(:secret)
			assign(:secrets, secret)
			render
			expect(rendered).to match('<a .*>Logout</a>')
		end

	end # /context authorized user

	context 'unauthorized user' do

		# DUP: 1
		before :each do
			def view.signed_in_user?
				false
			end

			def view.current_user
				nil
			end
		end

		it 'shows a login link for an unauthorized user' do
			secret = create(:secret)
			assign(:secrets, secret)
			render
			expect(rendered).to match('<a .*>Login</a>')
		end

	end # /context unauthorized user

end
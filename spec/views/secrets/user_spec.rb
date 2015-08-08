require 'rails_helper'
require 'pry'

describe "users/index.html.erb" do

	let(:user) {create(:user)}

	context 'signed in user can view logout link' do
	
	before do
		def view.signed_in_user?
			true
		end
	end

	

	end

end
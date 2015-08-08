require 'rails_helper'
require 'pry'

describe "shared/_navigation.html.erb" do

	let(:user) { create(:user) }

	before do
		# def view.current_user 
		# 	user
		# end
	end

  specify "a logged in user can see a logout link" do 
    def view.signed_in_user?
      true
    end

    allow(view).to receive(:current_user).with(:name => "Roger")

    render
    expect(rendered).to match("Logout")
  end

end
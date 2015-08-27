require 'rails_helper'

describe UsersController do
	
	describe 'user creation' do


		it 'redirects to #show with a valid user' do
			post :create, :user => attributes_for(:user)
			expect(response).to redirect_to user_path(assigns(:user))
		end


		it 'renders #new with an invalid user' do
			post :create, :user => attributes_for(:user, :name => nil)
			expect(response).to render_template :new
		end

	end


end
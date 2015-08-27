require 'rails_helper'

describe SecretsController do
	
	describe 'secrets access' do	

			before :each do
				create_list(:secret, 4)
			end

			describe 'GET #index' do

				it 'collects all secrets into @secrets if count < 5' do
					get :index
					expect(assigns(:secrets).count).to eq(4)
				end

				it 'collects all secrets into @secrets otherwise' do
					another_secret = create(:secret)
					get :index
					expect(assigns(:secrets)).to include(another_secret)
					expect(assigns(:secrets).count).to eq(5)
				end

			end

	end


	context 'authenticated user with secret' do

		let(:user){ create(:user_with_secret) }

		before :each do
			session[:user_id] = user.id
		end

			describe 'get #edit' do

				it 'can edit a secret user created' do
					get :edit, :id => user.secrets.first.id
					expect(response).to render_template :edit
				end

				it 'another user cannot edit this secret' do
					another_user = create(:user)
					session[:user_id] = another_user.id
					expect{ get :edit, :id => user.secrets.first.id }.to raise_error(ActiveRecord::RecordNotFound)
				end

				it 'cannot edit a secret user didnt create' do
					another_secret = create(:secret)
					expect { get :edit, :id => another_secret.id }.to raise_error(ActiveRecord::RecordNotFound)
				end

			end
			
		describe 'get #destroy' do

			it 'can delete a secret user created' do
				expect{ delete :destroy, :id => user.secrets.first.id }.to change(Secret, :count).by(-1)
			end

			it 'cannot delete a secret user didnt create' do
				another_secret = create(:secret)
				expect{ delete :destroy, :id => another_secret.id }.to raise_error
			end

		end

	end # /context authenticated user with secret

	context 'authenticated user without secret' do

		let(:user){ create(:user) }

		before :each do
			session[:user_id] = user.id
		end

		describe 'get #create' do

			it 'redirects to #show after creating a valid secret' do
				post :create, :secret => attributes_for(:secret, :author_id => user.id)
				expect(response).to redirect_to secret_path(assigns(:secret))
			end

			it 'renders #new after attempting to create an invalid secret' do
				post :create, :secret => attributes_for(:secret, :author_id => user.id, :body => nil)
				expect(response).to render_template :new
			end

			it 'creates a proper flash message after creating a valid secret' do
				post :create, :secret => attributes_for(:secret, :author_id => user.id)
				expect(flash.notice).to include('Secret was successfully created')
			end

			# NOTE: I created this in the SecretsController in order to fully understand how 
			# this works.
			it 'renders a proper flash message after attempting to create an invalid secret' do
				post :create, :secret => attributes_for(:secret, :author_id => user.id, :body => nil)
				expect(flash.notice).to include("Secret couldn't be created")
			end

		end

	end

end
require 'rails_helper'

describe 'UsersRequests' do
  let(:user){ create(:user) }
  describe 'POST #new' do
    it 'creates a new user' do
      expect{  post users_path, params: { user: attributes_for(:user) }}.to change(User, :count).by(1)
    end
    it 'redirects on successful signup' do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to have_http_status(:redirect)
    end
    it 're-renders if user input is invalid' do
      post users_path, params: {user: attributes_for(:user, name: nil)}
      expect(response).not_to have_http_status(:redirect)
    end
    it 'creates flash message on successful signup' do
      post users_path, params: {user: attributes_for(:user) }
      expect(flash[:notice]).to_not be_nil
    end
    it 'signs in user on successful signup' do
      post users_path, params: {user: attributes_for(:user) }
      expect(request.session[:user_id]).not_to be_nil
    end
  end
  describe 'PUT #update'do
    context 'logged in user' do
      before do
        controller_sign_in(user)
      end
      it 'updates user' do
        put user_path(user), params: { user: attributes_for(:user, name: 'FatCat') }
        user.reload
        expect(user.name).to eq('FatCat')
      end
      it 'redirects to user page' do
        put user_path(user), params: { user: attributes_for(:user) }
        expect(response).to redirect_to user_path(user)
      end
      it 'adds a flash notice' do
        put user_path(user), params: { user: attributes_for(:user) }
        expect(flash[:notice]).not_to be_nil
      end
    end
    context 'logged out user' do
      it 'redirects to login page' do
        put user_path(user), params: { user: attributes_for(:user, name: 'FatCat') }
        expect(response).to redirect_to new_session_path
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'logged in user' do
      before do
        controller_sign_in(user)
      end
      it 'destroys user' do
        expect{ delete user_path(user) }.to change(User, :count).by(-1)
      end
      it 'logs out user' do
        delete user_path(user)
        expect(session[:user_id]).to be_nil
      end
      it 'redirects to list of users' do
        delete user_path(user)
        expect(request).to redirect_to users_path
      end
      it 'adds a flash notice' do
        delete user_path(user)
        expect(flash[:notice]).not_to be_nil
      end
    end
    context 'logged out user' do
      it 'redirects user to sign in page' do
        delete user_path(user)
        expect(response).to redirect_to new_session_path
      end
    end
  end
end

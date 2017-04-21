require 'rails_helper'

describe 'SecretsRequests' do
  let(:user){ create(:user)}
  let(:secret){ create(:secret, author: user)}
  let(:anon_secret){ create(:secret)}
  describe 'GET#show' do
    it 'allows logged out user to view' do
      get secrets_path
      expect(response).to be_success
    end
    it 'allows logged in user to view' do
      post session_path(user)
      get secrets_path
      expect(response).to be_success
    end
  end
  describe 'PUT #update' do
    context 'logged in user' do
      before do
        controller_sign_in(user)
      end
      it 'can edit own secret' do
        put secret_path(secret), params: { secret: attributes_for(:secret, body: 'blah')}
        secret.reload
        expect(secret.body).to eq('blah')
      end
    end
    context 'logged out user' do
      it 'cannot edit secrets' do
        expect{ put secret_path(secret), params: { secret: attributes_for(:secret, body: 'blah')}}.to raise_error(NoMethodError)
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'logged in user' do
      before do
        controller_sign_in(user)
      end
      it 'deletes secrets' do
        secret
        expect{ delete secret_path(secret) }.to change(Secret, :count).by(-1)
      end
      it 'redirects upon deletion of secret' do
        delete secret_path(secret)
        expect(response).to redirect_to secrets_path
      end
    end
    context 'logged out user' do
      it 'does not delete secrets' do
        secret
        expect{ delete secret_path(secret)}.to change(Secret, :count).by(0)
      end
      it 'redirects user to login path' do
        delete secret_path(secret)
        expect(response).to redirect_to new_session_path
      end
    end
  end
  describe 'POST #create' do
    context 'logged in user' do
      before do
        controller_sign_in(user)
      end
      it 'creates secret' do
        expect { post secrets_path, params: { secret: attributes_for(:secret) } }.to change(Secret, :count).by(1)
      end
      it 'flashes notice on successful secret creation' do
        post secrets_path, params: {secret: attributes_for(:secret)}
        expect(flash[:notice]).not_to be_nil
      end
      it 'redirects to secret on successful secret creation' do
        post secrets_path, params: {secret: attributes_for(:secret)}
        expect(response).to have_http_status(302)
      end
    end
    context 'logged out user' do
      it 'redirects to sign in page' do
        post secrets_path, params: {secret: attributes_for(:secret)}
        expect(response).to redirect_to new_session_path
      end
    end
  end
end

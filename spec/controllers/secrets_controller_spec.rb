require 'rails_helper'


describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user) }
  let(:updated_title) { "This is a new title" }

  before :each do
    secret
    session[:user_id] = user.id
  end


  describe 'GET #show' do
    it 'sets the right instance variable' do
      secret
      get :show, id: secret.id

      expect(assigns(:secret)).to eq(secret)
    end
  end


  describe 'PUT#update' do

    it 'user can edit their own secret' do
      secret
      put :update, id: secret.id, secret: attributes_for(:secret, title: updated_title)
      secret.reload
      expect(secret.title).to eq(updated_title)
    end

    it 'redirects to the updated user' do
      secret
      put :update, id: secret.id, secret: attributes_for(:secret, title: updated_title)
      expect(response).to redirect_to assigns(:secret)
    end

  end


  describe 'GET#edit' do

    it 'works normal for this user' do
      get :edit, id: secret.id
      expect(response).to render_template :edit
    end

    it 'denies access for unauthorized user' do
      another_secret = create(:secret)
      expect { get :edit, id: another_secret.id }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'delete#Destroy' do

    it 'destroys a secret' do
      expect { delete :destroy, id: secret.id }.to change {Secret.count }.by(-1)
    end

    it 'redirects to the secrets_url' do
      delete :destroy, id: secret.id
      expect(response).to redirect_to secrets_url
    end

    it 'does not allow non-signed in user to destroy secret' do
      session[:user_id] = nil
      expect { delete :destroy, id: secret.id }.to change {Secret.count }.by(0)
    end
  end
end
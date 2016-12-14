require 'rails_helper'

describe SecretsController do

  describe 'secrets#show' do
    it 'sets secrets variable' do
      secret = create(:secret)
      get :show, { id: secret.id }
      expect(assigns(:secret)).to eq(secret)
    end

  end

  describe 'valid user' do

    let(:user){create(:user)}
    let(:user2){create(:user)}
    let(:secret){create(:secret, author: user)}

    it 'can edit their own secrets' do
      session[:user_id] = user.id
      put :update, id: secret.id, secret: attributes_for(:secret, title: "test title")
      secret.reload
      expect(secret.title).to eq("test title")
    end

    it 'Will not edit with bad params' do
      session[:user_id] = user.id
      put :update, id: secret.id, secret: attributes_for(:secret, title: "te")
      secret.reload
      expect(secret.title).to eq("Secret Title")
    end

    it 'Will not edit other users stuff' do
      session[:user_id] = user2.id
      expect {put :update, id: secret.id,
        secret: attributes_for(:secret, title: "test")
        }.to raise_error(ActiveRecord::RecordNotFound)
    end


    it 'can destroy their own secrets' do
      secret
      session[:user_id] = user.id
      expect{
        delete :destroy, id: secret.id
        }.to change(Secret, :count)
    end

    it 'Will not destroy other users stuff' do
      session[:user_id] = user2.id
      secret
      expect{
        delete :destroy, id: secret.id
        }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  describe 'secrets#create' do
    let(:user){create(:user)}

    it 'sets a flash message upon creation' do
      session[:user_id] = user.id
      post :create, secret: attributes_for(:secret)
      expect( controller ).to set_flash
    end

  end

  describe 'secrets#edit' do
    let(:secret){create(:secret)}

    it 'sets the proper variables' do
      get :edit, { id: secret.id }
      expect(assigns(:secret)).to eq(nil)
    end
  end

end

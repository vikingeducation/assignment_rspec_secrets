require 'rails_helper'


describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user) }
  let(:updated_title) { "This is a new title" }

  before :each do
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



  end





  end
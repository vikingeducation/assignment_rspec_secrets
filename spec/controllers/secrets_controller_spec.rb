require 'rails_helper'

describe SecretsController do

  describe 'User access' do
    let(:user)   { create(:user)   }
    let(:secret) { create(:secret, author: user) }

    describe 'get/show' do
      it 'sets the correct instance variable' do
        get :show, id: secret.id
        expect(assigns(:secret)).to eq(secret)
      end
    end

    describe 'patch/update' do
      before do
        secret
        session[:user_id] = user.id
      end

      it 'user owns secret and is able to update secret' do
        post :update, id: secret.id, secret: attributes_for(:secret, title: 'mynewtitle')
        secret.reload
        expect(secret.title).to eq('mynewtitle')
      end
    end

    describe 'post/destroy' do

    end
  end
end

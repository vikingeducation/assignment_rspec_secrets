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

    describe 'post/create' do
      before do
        session[:user_id] = user.id
      end

      it 'creates a secret when given valid attributes' do
        expect do
          post :create, secret: attributes_for(:secret)
        end.to change(Secret, :count).by(1)
      end

      it 'does not create a secret when given invalid attributes' do
        expect do
          post :create, secret: attributes_for(:secret, title: "")
        end.to_not change(Secret, :count)
      end

      it 'sets a flash message on create' do
        post :create, secret: attributes_for(:secret)
        expect(flash[:notice]).to_not be nil
      end
    end

    describe 'get/edit' do
      before do
        session[:user_id] = user.id
      end
      it 'sets the correct instance variables' do
        get :edit, id: secret.id
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

      it 'user does not own secret and is not able to update secret' do
        user_two = create(:user)
        session[:user_id] = user_two.id

        expect do
          post :update, id: secret.id, secret: attributes_for(:secret, title: 'mynewtitle')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

    end

    describe 'post/destroy' do
      before do
        secret
        session[:user_id] = user.id
      end

      it 'user owns secret and is able to destroy secret' do
        expect do
          post :destroy, id: secret.id
        end.to change(Secret, :count).by(-1)
      end

      it 'user does not own secret and is not able to destroy secret' do
        user_two = create(:user)
        session[:user_id] = user_two.id
        expect do
          post :destroy, id: secret.id
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

    end
  end
end

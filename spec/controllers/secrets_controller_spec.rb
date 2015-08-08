require 'rails_helper'

describe SecretsController do

  it 'secrets#show sets the right instance variable' do
   new_user = create(:user)
   new_secret = create(:secret, author: new_user)

   get :show, id: new_secret.id

   expect(assigns(:secret)).to eq(new_secret)
  end

  context 'authorized users' do

    let(:user){create(:user)}
    # let(:secret){create(:secret)}

    before :each do
      session[:user_id] = user.id
      @secret = create(:secret, author: user)
    end

    it 'should be able to create a secret' do


      expect{post :create, secret: attributes_for(:secret)}.to change(Secret, :count).by(1)

    end

    it 'should be able to edit/update their own secret' do
      updated = "new title"
      post :update, id: @secret.id, secret: attributes_for(:secret, title: updated)
      @secret.reload
      expect(@secret.title).to eq(updated)

    end

    it 'should be able to destroy their own secret' do

      expect{delete :destroy, id: @secret}.to change(Secret, :count).by(-1)

    end
  end

  context 'unauthorized users' do
    let(:user){create(:user)}

    before :each do
      session[:user_id] = user.id
      @secret = create(:secret)
    end

    it 'should not be able to edit/update their own secret' do
      updated = "new title"
      expect{post :update, id: @secret.id, secret: attributes_for(:secret, title: updated)}.to raise_error(ActiveRecord::RecordNotFound)

    end

    it 'should not be able to destroy their own secret' do
      expect{delete :destroy, id: @secret}.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end
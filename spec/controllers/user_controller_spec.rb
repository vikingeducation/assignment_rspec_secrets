require 'rails_helper'

describe UsersController do

  describe 'users#new' do

    it 'allows creation of a new user' do
      user = build(:user)
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it 'fails with bad parameters' do
      expect{
        post :create, user: { name: "p" }
      }.to_not change(User, :count)
    end

  end

  describe "account management" do
    let(:user){create(:user)}
    let(:user2){create(:user)}



    it 'can edit their own account' do
      session[:user_id] = user.id
      put :update, id: user.id, user: attributes_for(:user, name: "deziroth")
      user.reload
      expect(user.name).to eq("deziroth")
    end

    it 'Will not edit with bad params' do
      session[:user_id] = user.id
      put :update, id: user.id, user: attributes_for(:user, name: "")
      user.reload
      expect(user.name).to_not eq("")
    end

    it 'Will not edit other users accounts' do
      session[:user_id] = user2.id
      put :update, id: user.id, user: attributes_for(:user, name: "bromsfeild")
      user.reload
      expect(user.name).to_not eq("bromsfeild")
    end


    it 'can destroy their own account' do
      session[:user_id] = user.id
      expect{
        delete :destroy, id: user.id
        }.to change(User, :count)
    end

    it 'Will not destroy other users accounts' do
      session[:user_id] = user2.id
      user
       expect{
        delete :destroy, id: user.id
        }.to_not change(User, :count)
    end

  end

  describe 'users#edit' do
    let(:user){create(:user)}

    it 'sets the proper variables' do
      get :edit, { id: user.id }
      expect(assigns(:user)).to eq(nil)
    end
  end

end

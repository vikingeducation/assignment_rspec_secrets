require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }

  describe 'POST #create' do
    let(:post_create_user) do
      post :create, user: attributes_for(
            :user,
            email: 'foo@bar.com',
            password: 'foobar')
    end

    let(:post_create_invalid) do
      post :create, user: attributes_for(
            :user,
            email: '',
            password: '')
    end

    it 'creates a new user' do
      expect{ post_create_user }.to change(User, :count).by(1)
    end

    it 'does not create user if params are invalid' do
      expect{ post_create_invalid }.to change(User, :count).by(0)
    end
  end

  describe 'PUT #update' do
    let(:put_update_user) do
      put :update, 
          id: user.id,
          user: attributes_for(
          :user,
          email: 'bar@foo.com'
          )
    end

    let(:put_update_invalid) do
      put :update, 
          id: user.id,
          user: attributes_for(
          :user,
          email: ''
          )
    end

    before do
      user
      create_session(user)
    end

    it 'updates a user' do
      put_update_user
      user.reload
      expect(user.email).to eq('bar@foo.com')
    end

    it "doesn't update with invalid parameters" do
      email = user.email
      put_update_invalid
      user.reload
      expect(user.email).to eq(email)
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_user) do
      delete :destroy, id: user.id
    end

    let(:delete_destroy_invalid) do
      delete :destroy, id: '1234'
    end

    before do
      user
      create_session(user)
    end

    it 'deletes a user' do
      id = user.id
      delete_destroy_user
      expect{ User.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "doesn't delete unless current user" do
      destroy_session
      id = user.id
      delete_destroy_user
      expect{ User.find(id) }.not_to raise_error
    end
  end
end
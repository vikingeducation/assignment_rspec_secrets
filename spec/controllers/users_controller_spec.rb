require 'rails_helper'

describe UsersController do

  let(:user) { build(:user) }

  describe 'User creation' do

    describe 'post/create' do
      it 'creates a user when given valid attributes' do
        expect do
          post :create, user: attributes_for(:user)
        end.to change(User, :count).by(1)
      end

      it 'does not create a new user if attributes are invalid' do
        expect do
          post :create, user: attributes_for(:user, email: '')
        end.to_not change(User, :count)
      end
    end
  end

  describe 'get/edit' do
    it 'assigns the correct instace variable' do
      user.save
      session[:user_id] = user.id
      get :edit, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

end

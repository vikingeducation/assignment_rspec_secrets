require 'rails_helper'

describe UsersController do

  describe 'User creation' do
    let(:user) { build(:user) }

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
end

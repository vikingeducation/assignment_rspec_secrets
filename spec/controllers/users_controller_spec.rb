require 'rails_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe 'user#create' do


    context 'valid parameters' do
      it 'creates a user given' do

        expect{
          process :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)

      end
    end

    context 'invalid parameters' do
      it 'creates a user given' do

        expect{
          process :create, params: { user: attributes_for(:user, :bogus_params) }
        }.not_to change(User, :count)
      end

    end

  end

  describe 'user#update' do
    context 'valid parameters' do
      before do
        user
        session[:user_id] = user.id
      end

      it "editing a user does not create a new user" do
        expect{
          process :update, params: {id: user.id, user: { name: "new name", email: user.email, password: user.password, password_confirmation: user.password  } }
        }.not_to change(User, :count)
      end

      it "edits a user's information" do
        old_name = user.name

        process :update, params: {id: user.id, user: { name: "new name", email: user.email, password: user.password, password_confirmation: user.password  } }
        user.reload
        expect(old_name).to_not eq(user.name)
      end
    end
  end

end

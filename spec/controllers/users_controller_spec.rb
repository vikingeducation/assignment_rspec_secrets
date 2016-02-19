require 'rails_helper'


describe UsersController do

  let(:user) { create(:user) }

  describe 'POST#create' do

    it 'redirects to new user with valid params' do
      post :create, user: attributes_for(:user)

      expect(response).to redirect_to user_path(assigns(:user))
    end

    it 'creates new user with valid params' do
      expect { post :create, user: attributes_for(:user)
        }.to change { User.count}.by(1)
    end

    it 'renders new with invalid params' do
      post :create, user: attributes_for(:user, email: "")
      expect(response).to render_template :new
    end

    it 'does not create new user with invalid params' do
      post :create, user: attributes_for(:user, name: "hi")
      expect { assigns(:user).save! }.to raise_error(ActiveRecord::RecordInvalid)
    end


  end









  end
require 'rails_helper'

describe UsersController do
  let(:user) { create :user }

  context "creating a user" do
    it "creates a user with the correct submission" do
      expect { post :create, user: attributes_for(:user) }.to change(User,:count).by(1)
    end

    it "creates a user with the correct submission" do
      expect { post :create, user: attributes_for(:user, name: nil) }.to change(User,:count).by(0)
    end
  end

  context "edit" do

    before do
      session[:user_id] = user.id
    end

    it "sets the instance variable correctly" do
      get :edit, id: user.id

      expect( assigns(:user) ).to eq(user)
    end

  end
end

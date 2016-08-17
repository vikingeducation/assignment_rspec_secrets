require 'rails_helper'

describe UsersController do
  let(:user){create(:user)}


  describe 'POST #create' do

    it "actually creates the user" do
      expect{
        post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
    end

    it "doesn't actually create bad user" do
      expect{
        post :create, user: attributes_for(:user, email: "")
        }.to change(User, :count).by(0)
    end
  end

  describe "GET #edit" do 
    before do 
      user
      session[:user_id] = user.id
    end
    it "grabs the right user" do 
      get :edit, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

end 
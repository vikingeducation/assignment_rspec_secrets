require 'rails_helper'
require 'pry'

describe UsersController do

  let(:user) { build(:user) }

  context 'RESTful user actions' do

    describe "GET #new" do

      it "works as normal" do
        get :new
        expect(response).to render_template :new
      end

    end

    describe "POST #create" do

      it "proper submission creates a new user" do
        expect{ post :create, user: attributes_for(:user) }.
        to change(User, :count).by(1)
      end

      it "redirects to the user show page" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(user_path(assigns(:user)))
        # user.save
        # binding.pry
        # expect(request.fullpath).to eq(user_url(assigns(:user)))
      end

      describe "improper submission does not create a new user" do 
        specify "blank name does not create a new user" do 
          expect{post :create, user: attributes_for(:user, :name => nil)}.
          to change(User, :count).by(0) 
        end

        specify "blank email does not create a new user" do 
          expect{post :create, user: attributes_for(:user, :email => nil)}.
          to change(User, :count).by(0) 
        end

        specify "unmatched password does not create a new user" do 
          expect{post :create, user: attributes_for(:user, 
                                                    password: "1234", 
                                                    password_confirmation: "12345" )}.
          to change(User, :count).by(0) 
        end
      end
    end

    describe 'GET #edit' do

      before do
        user.save
        session[:user_id] = user.id
      end

      it "works as normal" do
        get :edit, id: user.id
        binding.pry
        expect(response).to render_template :edit
      end

    end

    describe 'PUT #update' do

    end

  end

end
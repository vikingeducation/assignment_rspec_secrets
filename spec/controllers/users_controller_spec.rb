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

    context "logged in user" do

      let(:user2) { create(:user) }

      before do
        user.save
        session[:user_id] = user.id
      end

      describe 'GET #edit' do

        it 'sets the right instance variable' do
        get :edit, :id => user.id
        expect(assigns(:user)).to eq(user)
      end

        it "works as normal" do
          get :edit, id: user.id
          expect(response).to render_template :edit
        end

        it "doesn't let you edit another user's profile" do
          get :edit, id: user2.id
          expect(response).not_to render_template :edit
        end

      end

      describe 'PUT #update' do

        it "can update user's own account" do
          put :update,  id: user.id,
                        user: attributes_for(:user,
                                              name: "Updated name")
          user.reload
          expect(user.name).to eq("Updated name")
        end

        it "cannot updated someone else's account" do
          put :update,  id: user2.id,
                        user: attributes_for(:user,
                                              name: "Updated name")
          user2.reload
          expect(user2.name).not_to eq("Updated name")
        end

      end

      describe 'DELETE #destroy' do

        it "can delete a user's own account" do
          expect{delete :destroy, id: user.id}.to change(User, :count).by(-1)
        end

        it "cannot delete another users' account" do
          user2
          expect{delete :destroy, id: user2.id}.to change(User, :count).by(0)
        end
      end

    end

  end

end
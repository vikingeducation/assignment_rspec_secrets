# spec/controllers/users_controller_spec.rb
require 'rails_helper'

describe UsersController do

  describe 'user access' do
    let(:user){ create(:user) }


    describe 'GET #show' do
      it "shows user" do
        session[:user_id] = user.id
        get :show, id: user.id
        expect(assigns(:user)).to match user
      end
 
    end
  #
    describe 'GET #new' do
      it "new user" do

        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

    end
  #
    describe 'POST #create' do
      it "creates a user" do

        expect {post :create, user: attributes_for(:user)
               }.to change(User, :count).by(1)
      end

    end

    describe 'POST #create redirects to show' do
      it "redirects after secret secret" do

        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end

    end

    describe 'POST #create creates a flash message for success' do
      it "creates a success flash message" do

        post :create, user: attributes_for(:user)
        expect(request.flash[:notice]).to_not be_nil
      end

    end

    describe 'POST #create creates a flash message for failure' do
      it "creates a failure flash message" do

        post :create, user: attributes_for(:user, name: "x")
        expect(response).to render_template :new
      end

    end
  #
  #
  #
   describe 'POST #updates redirects to show' do
      it "redirects after user update when logged in" do
        session[:user_id] = user.id
        put :update, id: user.id, user: attributes_for(:user, name: "New Name")
        expect(response).to redirect_to user_path(assigns(:user))
      end

    end

   describe 'POST #updates redirects to show' do
      it "redirects after user update when logged in" do
        session[:user_id] = user.id
        put :update, id: user.id, user: attributes_for(:user, name: "New Name")
        user.reload
        expect(user.name).to eq "New Name"
      end

   end

    describe 'DELETE #destroy when logged in' do
      it 'redirects to index after user is destroyed when user is logged in' do
        session[:user_id] = user.id
        delete :destroy, id: user.id
        expect(response).to redirect_to users_path
      end

      it 'redirects to index after user is destroyed when user is logged in' do
        session[:user_id] = user.id
        expect {delete :destroy, id: user.id
        }.to change(User, :count).by(-1)
      end
    end

    describe 'DELETE #destroy when not logged in' do
      it 'does not reduce the count of users by 1' do
        user
        #session[:user_id] = 12345
        expect {delete :destroy, id: user.id
        }.to change(User, :count).by(0)

      end
    end

    describe 'UPDATE #create when not logged in' do
      it 'does not update the user' do
        user
        put :update, id: user.id, user: attributes_for(:user, name: "New Name")
        expect(response).to redirect_to new_session_path
      end
    end
    
  end

end


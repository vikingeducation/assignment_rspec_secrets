require 'rails_helper'

describe UsersController do

  let(:user){ create(:user) }

  context "user is not logged in" do

    describe 'GET #new' do
      it "renders the new template" do
        get :new

        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      it "creates the new user" do
        expect{
          post :create, :user => attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to the user's show page if create is successful" do
        post :create, user: attributes_for(:user)

        expect(response).to redirect_to(assigns(:user))
      end

      it "renders the 'new' page if create is unsuccessful" do
        post :create, user: {nothing: 'fail'}

        expect(response).to render_template(:new)
      end
    end
  end

  context "user is logged in" do

    before do
      session[:user_id] = user.id
    end

    describe 'GET #edit' do
      it 'collects signed_in user into @user' do
        get :edit, :id => user.id

        expect(assigns(:user)).to eq(user)
      end
    end

    describe 'GET #index' do
      it "collects users into @users" do
        new_user = create(:user)

        # Make the actual request using the specified HTTP verb and action
        get :index

        expect(assigns(:users)).to match_array([user, new_user])
      end

      it "collects users into @ users (count check)" do
        new_user = create(:user)
        # AHHHHHH SO THIS IS WHY YOU HAVE TO CALL IT TO MAKE IT VALID
        user

        # Make the actual request using the specified HTTP verb and action
        get :index

        expect(assigns(:users).count).to eq(2)
      end

      it "renders the index template" do
        get :index

        expect(response).to render_template(:index)
      end
    end

    describe 'GET #show' do
      it "renders the show template" do
        get :show, :id => user.id

        expect(response).to render_template(:show)
      end
    end

    describe 'PATCH #update' do
      it 'collects user into @user' do
        patch :update, :id => user.id, :user => attributes_for(:user)

        expect(assigns(:user)).to eq(user)
      end

      it "doesn't change the number of users" do
        expect{
          patch :update, :id => user.id, :user => attributes_for(:user)
              }.to change(User, :count).by(0)
      end

      it "redirects to the user's show page if successful" do
        patch :update, :id => user.id, :user => attributes_for(:user)

        expect(response).to redirect_to(user)
      end

      it "renders the edit page if update unsuccessful" do
        patch :update, :id => user.id, :user => {:name => ""}

        expect(response).to render_template(:edit)
      end

      # I guess I'd want to make sure that the update was successful.
      it "successfully updates the user's name" do
        new_name = "Kate Bush"
        patch :update, :id => user.id, :user => { :name => new_name, :email => "prime_pork@hotmail.com", :password => "clamocop", :confirm_password => "clamocop" }

        expect(response).to redirect_to(user)
        ## WHY YOU NO WORK??? BECAUSE I HAVEN'T RELOADED THE USER!!
        user.reload

        expect(user.name).to eq(new_name)
      end
    end

    describe "DELETE #destroy" do

      it "assigns @user" do
        delete :destroy, :id => user.id

        expect(assigns(:user)).to eq(user)
      end

      it "deletes a user" do
        expect{
          delete :destroy, :id => user.id
          }.to change(User, :count).by(-1)
      end

      # currently you can delete other users and your own account.
      # I fully don't get these ones!!!! But will leave behind.
      it "redirects to user's page after deleting someone else's account" do
        new_user = create(:user)
        delete :destroy, :id => new_user.id

        expect(response).to redirect_to(root_path)
      end

      it "raises_error if user deletes his own account" do
        delete :destroy, :id => user.id
        expect(response).to redirect_to(users_path)
      end

    end

    describe 'set_user' do
      it "sets @user" do
        get :show, :id => user.id
        expect(assigns(:user)).to eq(user)
      end

      it "sets @user" do
        get :show, :id => 1
        expect(assigns(:user)).to eq(User.find(1))
      end
    end

  end

end
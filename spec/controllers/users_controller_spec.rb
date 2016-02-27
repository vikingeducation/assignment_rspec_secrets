require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }

  describe "POST #create" do

    it "with proper attributes creates the user" do
      expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
    end

    it "with improper attributes does not create the user" do
      expect{post :create, user: attributes_for(:user, email: nil)}.not_to change(User, :count)
    end

    it "sets a flash message on create" do
      post :create, user: attributes_for(:user)
      expect(flash[:notice]).to eq('User was successfully created.')
    end
  end

  describe "GET #edit" do
    context 'logged in user' do

      context 'is current user' do
        before { session[:user_id] = user.id }

        it 'sets the user as @user' do
          get :edit, :id => user.id
          expect(assigns(:user)).to eq(user)
        end

        it 'renders the :edit template' do
          get :edit, :id => user.id
          expect(response).to render_template :edit
        end
      end

      context 'is not current user' do
        let(:user_2){ create(:user) }

        before do
          session[:user_id] = user_2.id
        end

        it 'redirects to root' do
          get :edit, :id => user.id
          expect(response).to redirect_to(root_url)
        end

        it 'creates a flash message' do
          get :edit, :id => user.id
          expect(flash[:error]).to eq("You're not authorized to view this")
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        get :edit, id: user.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'POST #update' do

    context 'logged in user' do

      context 'is current user' do
        let(:updated_email){ "update@email.com" }

        before do
          session[:user_id] = user.id
        end

        it 'sets the user as @user' do
          put :update, :id => user.id, user: attributes_for(:user, email: updated_email)
          expect(assigns(:user)).to eq(user)
        end

        it "with proper attributes updates the user" do
          put :update,
            id: user.id,
            user: attributes_for(:user, email: updated_email)
          user.reload
          expect(user.email).to eq("update@email.com")
        end
      end

      context 'is not current user' do
        let(:user_2){ create(:user) }
        before { session[:user_id] = user_2.id }

        it 'redirects to root' do
          put :update, :id => user.id
          expect(response).to redirect_to(root_url)
        end

        it 'creates a flash message' do
          put :update, :id => user.id
          expect(flash[:error]).to eq("You're not authorized to view this")
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        put :update, id: user.id, user: attributes_for(:user)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'logged in user' do

      context 'is current user' do

        before do
          session[:user_id] = user.id
        end

        it 'sets the user as @user' do
          delete :destroy, :id => user.id
          expect(assigns(:user)).to eq(user)
        end

        it "deletes the user" do
          expect{delete :destroy, id: user.id}.to change(User, :count).by(-1)
        end
      end

      context 'is not current user' do
        let(:user_2){ create(:user) }
        before { session[:user_id] = user_2.id }

        it 'redirects to root' do
          delete :destroy, :id => user.id
          expect(response).to redirect_to(root_url)
        end

        it 'creates a flash message' do
          delete :destroy, :id => user.id
          expect(flash[:error]).to eq("You're not authorized to view this")
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        delete :destroy, id: user.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end

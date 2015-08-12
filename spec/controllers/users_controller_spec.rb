require 'rails_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe 'POST #create' do

    it 'creates a user with a valid submission' do
      post :create, :user => attributes_for(:user)
      expect(response).to redirect_to( user_path( assigns(:user) ) )
      expect(flash[:notice]).to eq('User was successfully created.')
    end


    it 're-renders form with errors on invalid submission' do
      post :create, :user => attributes_for(:user, :name => nil)
      expect(response).to render_template(:new)
      expect(assigns(:user).errors).not_to be_empty
    end

  end


  describe 'PUT #update' do


    let(:new_name) { "Mr. Foo" }
    before { user }

    context 'with valid authentication' do

      before :each do
        session[:user_id] = user.id
        update_user(user, :name => new_name)
      end


      context 'with valid attributes' do

        it 'sets the user ivar' do
          expect(assigns(:user)).to eq(user)
        end

        it 'can edit her own user profile' do
          user.reload
          expect(user.name).to eq(new_name)
        end

        it 'redirects to show' do
          expect(response).to redirect_to(user_path(user.id))
        end

      end


      context 'with invalid attributes' do
        let(:new_name) { nil }

        it 'finds the user' do
          expect(assigns(:user)).to eq(user)
        end


        it 'fails to update the user profile' do
          user.reload
          expect(user.name).not_to eq(new_name)
        end

        it 're-renders edit form with errors' do
          expect(response).to render_template(:edit)
          expect(assigns(:user).errors).not_to be_empty
        end

      end

    end


    context 'without valid authentication' do

      let(:other_user) { create(:user) }
      before do
        session[:user_id] = other_user.id
        update_user(user, :name => new_name)
      end

      it 'flashes a not authorized message' do
        expect(flash[:error]).to eq("You're not authorized to view this")
      end

      it 'redirects to root' do
        expect(response).to redirect_to(root_url)
      end

      it 'does not update the user profile' do
        expect(user.name).not_to eq(new_name)
      end

    end

  end



  describe 'DELETE #destroy' do

    before { user }


    context 'with valid authentication' do

      before do
        session[:user_id] = user.id
      end

      it 'finds the user' do
        delete :destroy, :id => user.id
        expect(assigns(:user)).to eq(user)
      end

      it 'can destroy her own account' do
        expect{ delete :destroy,  :id => user.id }.to change(User, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, :id => user.id
        expect(response).to redirect_to(users_path)
      end

    end


    context 'without valid authentication' do

      let(:other_user) { create(:user) }
      before do
        session[:user_id] = other_user.id
        delete :destroy, :id => user.id
      end

      it 'flashes a not authorized message' do
        expect(flash[:error]).to eq("You're not authorized to view this")
      end

      it 'redirects to root' do
        expect(response).to redirect_to(root_url)
      end

      it 'does not update the user profile' do
        expect(user.reload).to be_truthy
      end
    end

  end

end
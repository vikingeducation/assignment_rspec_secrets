require 'rails_helper'

describe UsersController do
  let(:user){create(:user)}
  let(:users){create_list(:user, 5)}

  # ----------------------------------------
  # GET #index
  # ----------------------------------------
  describe 'GET #index' do
    it 'sets an instance variable to all users' do
      users
      process :index
      expect(assigns(:users).map(&:id)).to eq(users.map(&:id))
    end
  end

  # ----------------------------------------
  # GET #show
  # ----------------------------------------
  describe 'GET #show' do
    it 'sets an instance variable to the desired user when user is authorized' do
      login(user)
      process :show, params: { :id => user.id }
      expect(assigns(:user).id).to eq(user.id)
    end

    it 'redirects to login when user is not authorized' do
      process :show, params: { :id => user.id }
      expect(response).to redirect_to new_session_path
    end
  end

  # ----------------------------------------
  # GET #new
  # ----------------------------------------
  describe 'GET #new' do
    it 'sets an instance variable to an empty unpersisted user' do
      process :new
      expect(assigns(:user)).to_not be_persisted
    end
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------
  describe 'POST #create' do
    let(:post_create_user) do
      process :create, params: {
        :user => attributes_for(
          :user,
          :name => 'Foobar',
          :email => 'foo@bar.com',
          :password => 'password',
          :password_confirmation => 'password'
        )
      }
    end

    let(:post_create_invalid) do
      process :create, params: {
        :user => attributes_for(
          :user,
          :name => '',
          :email => '',
          :password => '',
          :password_confirmation => ''
        )
      }
    end

    context 'the submitted data is valid' do
      it 'creates a new user' do
        expect do
          post_create_user
        end.to change(User, :count).by(1)
      end

      it 'sets the appropriate flash message when creation succeeds' do
        post_create_user
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'the submitted data is invalid' do
      it 'does not create a new user' do
        expect do
          post_create_invalid
        end.to change(User, :count).by(0)
      end

      it 'renders the new' do
        post_create_invalid
        expect(response).to render_template :new
      end
    end
  end

  # ----------------------------------------
  # GET #edit
  # ----------------------------------------
  describe 'GET #edit' do
    it 'sets an instance variable to the desired persisted user when authorized' do
      login(user)
      process :edit, params: { :id => user.id }
      expect(assigns(:user).id).to eq(user.id)
    end

    it 'redirects when not authorized' do
      user = users.first
      login(user)
      process :edit, params: { :id => users.last.id }
      expect(response).to redirect_to root_path
    end
  end

  # ----------------------------------------
  # PUT/PATCH #update
  # ----------------------------------------
  describe 'PUT/PATCH #update' do
    let(:patch_update_user) do
      process :update, params: {
        :id => user.id,
        :user => attributes_for(
          :user,
          :name => 'Foobar',
          :email => 'foo@bar.com',
          :password => 'password',
          :password_confirmation => 'password'
        )
      }
    end

    let(:patch_update_invalid) do
      process :update, params: {
        :id => user.id,
        :user => attributes_for(
          :user,
          :name => '',
          :email => ''
        )
      }
    end

    before do
      login(user)
    end

    it 'redirects when the user is not authorized' do
      logout
      patch_update_user
      expect(response).to redirect_to new_session_path
    end

    context 'the data is valid' do
      it 'updates an existing user when the user is authorized' do
        patch_update_user
        user.reload
        expect(user.name).to eq('Foobar')
      end

      it 'sets the appropriate flash message when updating succeeds' do
        patch_update_user
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'the data is invalid' do
      it 'does not update the user' do
        name = user.name
        patch_update_invalid
        expect(user.name).to eq(name)
      end

      it 'renders the edit template' do
        patch_update_invalid
        expect(response).to render_template :edit
      end
    end
  end

  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------
  describe 'DELETE #destroy' do
    let(:delete_destroy_user){ process :destroy, params: { :id => user.id } }
    let(:delete_destroy_other_user){ process :destroy, params: { :id => users.first.id } }

    before do
      login(user)
    end

    context 'the user is logged in' do
      it 'removes a user from the database' do
        expect do
          delete_destroy_user
        end.to change(User, :count).by(-1)
      end

      it 'the current user is deleted' do
        delete_destroy_user
        expect do
          User.find(user.id)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'signs out the current user after destroy' do
        delete_destroy_user
        expect(session[:user_id]).to be_nil
      end

      it 'does not delete a user when attempting to delete other users' do
        users
        expect do
          delete_destroy_other_user
        end.to change(User, :count).by(0)
      end

      it 'sets the appropriate flash message when deletion succeeds' do
        delete_destroy_user
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'the user is logged out' do
      before do
        logout
      end

      it 'does not destroy the user' do
        expect do
          delete_destroy_user
        end.to change(User, :count).by(0)
      end

      it 'redirects' do
        delete_destroy_user
        expect(response).to redirect_to new_session_path
      end
    end
  end
end









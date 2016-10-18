require 'rails_helper'

describe SecretsController do
  let(:user){create(:user)}
  let(:secret){create(:secret, :author => user)}
  let(:secrets){create_list(:secret, 2, :author => user)}

  before do
    login(user)
  end

  # ----------------------------------------
  # GET #index
  # ----------------------------------------
  describe 'GET #index' do
    it 'sets an instance variable to all secrets' do
      secrets
      process :index
      expect(assigns(:secrets).map(&:id)).to eq(secrets.map(&:id))
    end
  end

  # ----------------------------------------
  # GET #show
  # ----------------------------------------
  describe 'GET #show' do
    it 'sets an instance variable to the desired secret' do
      process :show, params: { :id => secret.id }
      expect(assigns(:secret)).to eq(secret)
    end
  end

  # ----------------------------------------
  # GET #new
  # ----------------------------------------
  describe 'GET #new' do
    context 'the user is logged in' do
      it 'sets an instance variable to an empty unpersisted secret' do
        process :new
        expect(assigns(:secret).persisted?).to eq(false)
      end
    end

    context 'the user is logged out' do
      it 'redirects to the login path' do
        logout
        process :new
        expect(response).to redirect_to new_session_path
      end
    end
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------
  describe 'POST #create' do
    let(:post_create_secret) do
      process :create, params: {
        :id => user.id,
        :secret => attributes_for(
          :secret,
          :title => 'title',
          :body => 'body'
        )
      }
    end

    let(:post_create_invalid) do
      process :create, params: {
        :id => user.id,
        :secret => attributes_for(
          :secret,
          :title => '',
          :body => ''
        )
      }
    end

    it 'redirects when user is not authorized' do
      logout
      post_create_secret
      expect(response).to redirect_to new_session_path
    end

    context 'the data is valid' do
      it 'creates a new secret when the user is authorized' do
        expect do
          post_create_secret
        end.to change(Secret, :count).by(1)
      end

      it 'sets the appropriate flash message when creation succeeds' do
        post_create_secret
        expect(flash[:notice]).to_not be_nil
      end

      it 'does not create a secret when the user is unauthorized' do
        logout
        expect do
          post_create_secret
        end.to change(Secret, :count).by(0)
      end
    end

    context 'the data is invalid' do
      it 'does not create a new secret' do
        expect do
          post_create_invalid
        end.to change(Secret, :count).by(0)
      end

      it 'renders the new view' do
        post_create_invalid
        expect(response).to render_template :new
      end
    end
  end

  # ----------------------------------------
  # GET #edit
  # ----------------------------------------
  describe 'GET #edit' do
    it 'sets an instance variable to the desired persisted secret' do
      process :edit, params: { :id => secret.id }
      expect(assigns(:secret)).to eq(secret)
    end
  end

  # ----------------------------------------
  # PUT/PATCH #update
  # ----------------------------------------
  describe 'PUT/PATCH #update' do
    let(:patch_upate_secret) do
      process :update, params: {
        :id => user.id,
          :secret => attributes_for(
            :secret,
            :title => 'UPDATED!',
            :body => 'UPDATED!'
          )
      }
    end

    let(:patch_upate_invalid) do
      process :update, params: {
        :id => user.id,
          :secret => attributes_for(
            :secret,
            :title => '',
            :body => ''
          )
      }
    end

    before do
      secret
      login(user)
    end

    it 'redirects when the user is not authorized' do
      logout
      patch_upate_secret
      expect(response).to_not redirect_to secret
    end

    context 'the data is valid' do
      it 'updates an existing secret when the user is authorized' do
        patch_upate_secret
        secret.reload
        expect(secret.title).to eq('UPDATED!')
      end

      it 'sets the appropriate flash message when updating succeeds' do
        patch_upate_secret
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'the data is invalid' do
      it 'does not update the secret' do
        title = secret.title
        patch_upate_invalid
        secret.reload
        expect(secret.title).to eq(title)
      end

      it 'renders the edit template' do
        patch_upate_invalid
        expect(response).to render_template :edit
      end
    end
  end

  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------
  describe 'DELETE #destroy' do
    let(:delete_destroy_secret){ process :destroy, params: { :id => secret.id } }

    before do
      secret
      login(user)
    end

    it 'destroys an existing secret when the user is authorized' do
      expect do
        delete_destroy_secret
      end.to change(Secret, :count).by(-1)
    end

    it 'redirects when the user is not authorized' do
      logout
      delete_destroy_secret
      expect(response).to redirect_to new_session_path
    end

    it 'sets the appropriate flash message when deletion succeeds' do
      delete_destroy_secret
      expect(flash[:notice]).to_not be_nil
    end
  end
end












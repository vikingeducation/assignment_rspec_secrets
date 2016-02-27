require 'rails_helper'

describe SecretsController do

  let(:secret){ create(:secret) }
  let(:invalid_secret){ create(:invalid_secret) }
  let(:user){ create(:user) }

  describe "GET #show" do
    before { secret }

    it "sets the secret as @secret" do
      get :show, :id => secret.id
      expect(assigns(:secret)).to eq(secret)
    end

    it "renders the :show template" do
      get :show, :id => secret.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do

    context 'logged in user' do

      context 'is secret owner' do
        let(:user_with_secret){ create(:user_with_secret) }
        before { session[:user_id] = user_with_secret.id }

        it 'sets the secret as @secret' do
          get :edit, :id => user_with_secret.secrets.first.id
          expect(assigns(:secret)).to eq(user_with_secret.secrets.first)
        end

        it 'renders the :edit template' do
          get :edit, :id => user_with_secret.secrets.first.id
          expect(response).to render_template :edit
        end
      end

      context 'is not secret owner' do
        before { session[:user_id] = user.id }

        it 'raises an error' do
          expect{get :edit, id: secret.id}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        get :edit, id: secret.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'POST #update' do

    context 'logged in user' do

      context 'is secret owner' do
        let(:user_with_secret){ create(:user_with_secret) }
        let(:user_secret){ user_with_secret.secrets.first }
        let(:updated_title){ "updated title" }

        before do
          session[:user_id] = user_with_secret.id
        end

        it 'sets the secret as @secret' do
          put :update, :id => user_secret.id, secret: attributes_for(:secret, title: updated_title)
          expect(assigns(:secret)).to eq(user_secret)
        end

        it "with proper attributes updates the secret" do
          put :update,
            id: user_secret.id,
            secret: attributes_for(:secret, title: updated_title)
          user_secret.reload
          expect(user_secret.title).to eq("updated title")
        end
      end

      context 'is not secret owner' do
        before { session[:user_id] = user.id }

        it 'raises an error' do
          expect{put :update, id: secret.id, secret: attributes_for(:secret)}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        put :update, id: secret.id, secret: attributes_for(:secret)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "POST #create" do

    context "logged in user" do
      before { session[:user_id] = user.id }

      it "with proper attributes creates the secret" do
        expect{post :create, secret: attributes_for(:secret)}.to change(Secret, :count).by(1)
      end

      it "with improper attributes does not create the secret" do
        expect{post :create, secret: attributes_for(:invalid_secret)}.not_to change(Secret, :count)
      end

      it "sets a flash message on create" do
        post :create, secret: attributes_for(:secret)
        expect(flash[:notice]).to eq('Secret was successfully created.')
      end
    end

    context "no user logged in" do

      it "does not create a secret" do
        expect{post :create, secret: attributes_for(:secret)}.not_to change(Secret, :count)
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'logged in user' do

      context 'is secret owner' do
        let(:user_with_secret){ create(:user_with_secret) }
        let(:user_secret){ user_with_secret.secrets.first }

        before do
          session[:user_id] = user_with_secret.id
        end

        it 'sets the secret as @secret' do
          delete :destroy, :id => user_secret.id
          expect(assigns(:secret)).to eq(user_secret)
        end

        it "deletes the secret" do
          expect{delete :destroy, id: user_secret.id}.to change(Secret, :count).by(-1)
        end
      end

      context 'is not secret owner' do
        before { session[:user_id] = user.id }

        it 'raises an error' do
          expect{delete :destroy, id: secret.id}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "no user logged in" do

      it 'redirects to login' do
        delete :destroy, id: secret.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

end
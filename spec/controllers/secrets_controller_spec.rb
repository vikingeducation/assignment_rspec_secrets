require 'rails_helper'

describe SecretsController do

  let(:secret) { create(:secret) }


  describe 'GET #show' do

    it 'sets @secret with current secret' do
      get :show, id: secret

      expect(assigns(:secret)).to eq(secret)
    end

  end


  describe 'PUT #update' do

    let(:new_body) { "Updated foo secret" }
    before { secret }


    context 'with valid authentication' do

      before :each do
        session[:user_id] = secret.author_id
        update_secret(secret, :body => new_body)
      end


      context 'with valid attributes' do

        it 'finds the secret' do
          expect(assigns(:secret)).to eq(secret)
        end

        it 'can edit her own secret' do
          secret.reload
          expect(secret.body).to eq(new_body)
        end

        it 'redirects to show' do
          expect(response).to redirect_to(secret_path(secret.id))
        end

      end


      context 'with invalid attributes' do
        let(:new_body) { nil }

        it 'sets the secret ivar' do
          expect(assigns(:secret)).to eq(secret)
        end


        it 'fails to update the secret' do
          secret.reload
          expect(secret.body).not_to eq(new_body)
        end

        it 're-renders edit form with errors' do
          expect(response).to render_template(:edit)
          expect(assigns(:secret).errors).not_to be_empty
        end

      end

    end


    context 'without valid authentication' do

      let(:other_user) { create(:user) }
      before do
        session[:user_id] = other_user.id
      end

      it 'throws an error when trying to find the secret' do
        expect { update_secret(secret, :body => new_body) }.to raise_exception(ActiveRecord::RecordNotFound)
      end

    end

  end



  describe 'DELETE #destroy' do

    before { secret }


    context 'with valid authentication' do

      before do
        session[:user_id] = secret.author_id
      end

      it 'finds the secret' do
        delete :destroy, :id => secret.id
        expect(assigns(:secret)).to eq(secret)
      end

      it 'can destroy her own secret' do
        expect{ delete :destroy,  :id => secret.id }.to change(Secret, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, :id => secret.id
        expect(response).to redirect_to(secrets_path)
      end

    end


    context 'without valid authentication' do

      let(:other_user) { create(:user) }
      before do
        session[:user_id] = other_user.id
      end

      it 'throws an erorr when trying to find the secret' do
        expect { delete :destroy,  :id => secret.id }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

  end


  describe 'POST #create' do

    context 'with a logged in user' do
      let(:logged_in_user) { create(:user) }
      before do
        session[:user_id] = logged_in_user.id
      end

      context 'with valid attributes' do
        before do
          post :create, :secret => attributes_for(:secret, :author => logged_in_user)
        end

        it 'creates the new secret' do
          expect(assigns(:secret)).to be_persisted
        end

        it 'redirects to secret show page' do
          expect(response).to redirect_to(secret_path(assigns(:secret)))
        end

        it 'flashes success message' do
          expect(flash[:notice]).to eq('Secret was successfully created.')
        end
      end

      context 'with invalid attributes' do
        before do
          post :create, :secret => attributes_for(:secret, :author => logged_in_user, :body => nil)
        end

        it 'renders new template with errors' do
          expect(response).to render_template(:new)
          expect(assigns(:secret).errors).not_to be_empty
        end

      end

    end

  end


end
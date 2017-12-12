require 'rails_helper'

RSpec.describe 'SecretsController', type: :request do
  describe 'GET /secrets/:id' do
    it 'works' do
      secret = create :secret
      get secret_path(secret)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    before do
      user = create :user
      post session_path, params: { email: user.email, password: user.password }
    end

    context 'with valid attributes' do
      it 'creates a secret' do
        expect {
          post secrets_path, params: { secret: attributes_for(:secret) }
        }.to change(Secret, :count).by(1)
      end

      it 'sets a flash message' do
        post secrets_path, params: { secret: attributes_for(:secret) }
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not create post' do
        post secrets_path,
             params: { secret: attributes_for(:secret, body: nil) }
        expect(response).to have_http_status(:ok)
      end

      it 'does not set the flash' do
        post secrets_path,
             params: { secret: attributes_for(:secret, body: nil) }
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe 'PATCH #update' do
    context 'Logged in user' do
      let(:new_title) { 'New Title' }

      context 'secret owned by logged in user' do
        let(:secret) { create :secret }
        let(:user) { secret.author }

        before do
          post session_path,
               params: { email: user.email, password: user.password }
        end

        it 'updates secret' do
          patch secret_path(secret), params: { secret: { title: new_title } }

          expect(response).to have_http_status(:redirect)
          expect(secret.reload.title).to eq new_title
        end
      end

      context 'secret not owned by logged in user' do
        let(:secret) { create :secret }

        before do
          user = create :user
          post session_path,
               params: { email: user.email, password: user.password }

          patch secret_path(secret), params: { secret: { title: new_title } }
        end

        it 'does not update secret' do
          expect(response).to have_http_status(:redirect)
          expect(secret.reload.title).not_to eq new_title
        end

        it 'sets the flash notice' do
          expect(flash[:notice]).to match /Not authorized/
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Logged in user' do
      context 'secret owned by logged in user' do
        let(:secret) { create :secret }
        let(:user) { secret.author }

        before do
          post session_path,
               params: { email: user.email, password: user.password }
        end

        it 'deletes secret' do
          expect {
            delete secret_path(secret), params: { secret: secret }
          }.to change(Secret, :count).by(-1)
        end
      end

      context 'secret not owned by logged in user' do
        let(:secret) { create :secret }

        before do
          user = create :user
          post session_path,
               params: { email: user.email, password: user.password }

          delete secret_path(secret), params: { secret: secret }
        end

        it 'does not delete secret' do
          expect(response).to have_http_status(:redirect)
        end

        it 'sets the flash notice' do
          expect(flash[:notice]).to match /Not authorized/
        end
      end
    end
  end
end

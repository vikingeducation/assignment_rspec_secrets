require 'rails_helper'

describe SecretsController do
  let(:user){ create(:user) }
  let(:secret){ create(:secret, author: user) }

  describe 'GET #show' do
    it 'sets instance variable correctly' do
      get :show, { id: secret.id }
      expect(assigns(:secret)).to eq(secret)
    end
  end

  describe 'POST #create' do
    let(:secret_create) do
      post :create, secret: attributes_for(
            :secret,
            title: 'Test title',
            body: 'Test body',
            author_id: user.id)
    end

    before do
      user
      create_session(user)
    end

    it 'creates a secret when signed in' do
      expect{ secret_create }.to change(Secret, :count).by(1)
    end

    it 'creates a flash message when created' do
      secret_create
      expect(flash.notice).to eq("Secret was successfully created.")
    end
  end

  describe 'PUT #update' do
    let(:secret_update) do
      put :update, 
          id: secret.id,
          secret: attributes_for(
            :secret,
            title: 'New title',
            body: 'New body',
            author_id: user.id)
    end

    let(:secret_update_invalid) do
      put :update, 
          id: secret.id,
          secret: attributes_for(
            :secret,
            title: '',
            body: '',
            author_id: user.id)
    end

    before do
      user
      create_session(user)
      secret
    end

    it 'secrets can be updated' do
      secret_update
      secret.reload
      expect(secret.title).to eq('New title')
    end

    it "secret not updated with invalid params" do
      secret_update_invalid
      secret.reload
      expect(secret.title).not_to eq('New title')
    end
  end

  describe 'DELETE #destroy' do
    let(:secret_destroy) do
      delete :destroy, id: secret.id
    end

    before do
      user
      create_session(user)
      secret
    end

    it 'secret can be destroyed' do
      id = secret.id
      secret_destroy
      expect{ Secret.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "secret can't be destroyed if not logged in" do
      destroy_session
      id = secret.id
      secret_destroy
      expect{ Secret.find(id) }.not_to raise_error
    end
  end
end
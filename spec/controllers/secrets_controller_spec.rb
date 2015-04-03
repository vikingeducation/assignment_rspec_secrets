require 'rails_helper'
require 'pry'

describe SecretsController do
  let!(:secret){ create(:secret) }
  let(:user){ create(:user) }
  let(:other_secret){ create(:secret) }

  describe 'GET #show' do
    it 'assigns the right secret to the instance variable' do
      get :show, id: secret.id
      expect(assigns(:secret)).to match secret
    end
  end
  describe 'GET #edit' do
    it 'sets the right instance variable' do
      get :edit, {id: secret.id}, {user_id: secret.author.id}
      expect(assigns(:secret)).to match secret
    end
    specify 'user can edit their own post' do
      get :edit, {id: secret.id}, {user_id: secret.author.id}
      expect(response).to render_template(:edit)
    end
    it 'user cannot edit a post that is not theirs' do
      expect{
	get :edit, {id: other_secret.id}, {user_id: secret.author.id}
      }.to raise_error
    end
  end
  describe 'POST #create' do
    it 'a proper submission with a logged-in viewer will create a new secret' do
      post :create, {secret: attributes_for(:secret)}, {user_id: user.id}
      expect(assigns(:secret)).to be_persisted
    end
  end
  describe 'DELETE #destroy' do
    it 'user can delete their own post' do
      expect{
	delete :destroy, {id: secret.id}, {user_id: secret.author.id}
      }.to change(Secret, :count).by -1
    end
    it 'user cannot delete a post that is not theirs' do
      expect{
	delete :destroy, {id: other_secret.id}, {user_id: secret.author.id}
      }.to raise_error
    end
  end
end

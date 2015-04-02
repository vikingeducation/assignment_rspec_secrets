require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }
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
    specify 'user can edit their own post'
    it 'user cannot edit a post that is not theirs'
  end
  describe 'POST #create' do
    it 'a proper submission with a logged-in viewer will create a new secret'
  end
  describe 'DELETE #destroy' do
    it 'user can delete their own post'
    it 'user cannot delete a post that is not theirs'
  end
end

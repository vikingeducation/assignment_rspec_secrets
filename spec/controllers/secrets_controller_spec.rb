require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }
  describe 'GET #show' do
    it 'assigns the right secret to the instance variable' do
      get :show, id: secret.id
      expect(assigns(:secret)).to match secret
    end
  end
end

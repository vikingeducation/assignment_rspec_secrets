require 'rails_helper'

describe 'SecretsRequests' do
  let(:user){ create(:user) }
  let(:secret){create(:secret, :author => user)}

  describe 'GET #show' do
    it "returns successful response" do
      binding.pry

      get secret_path(secret), params: {id: secret.id}
      expect(response).to be_success
    end
  end
end

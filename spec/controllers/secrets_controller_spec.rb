require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }
  let(:user){ secret.author }

  before do
    secret
  end

  describe "GET #show" do
    it "properly sets @secret" do
      process :show, params: {id: secret.id}
      expect(assigns(:secret)).to eq(secret)
    ends
  end
end

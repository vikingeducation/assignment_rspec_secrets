# spec/requests/secrets_request_spec.rb
require 'rails_helper'

describe "SecretsRequests" do
  describe "secret access" do
    let(:secret) { create(:secret) }
    let(:author) { secret.author }

    # let(:author) { create(:user) }
    # let(:secret) { author.secrets.create(attributes_for(:secret)) }

    # login before each spec
    before :each do
      login_as(author)
    end

    describe "GET #show" do
      before { secret }

      it "returns a successful response" do
        get secret_path(secret)
        expect(response).to be_success

        delete session_path
        get secret_path(secret)
        expect(response).to be_success
      end
    end
  end
end

# # spec/requests/secrets_request_spec.rb
require 'rails_helper'

describe 'SecretsRequests' do
  
  let(:secret){ create(:secret) }
  let(:author){ secret.author}

  before :each do 
    secret
    post session_path, params: { email: author.email, password: author.password }
  end

  describe 'Secrets' do
    it "Verify that secrets #show returns a successful response. " do
      get secret_path(secret)
      expect(response).to be_success
    end

    it "Secret is created" do
    expect{
        post secrets_path, params: { secret: attributes_for(:secret) }
      }.to change(Secret, :count).by(1)
    end

    it "Verify that this Secret creation sets a flash message." do
      post secrets_path, params: { :secret => attributes_for(:secret) }
      expect(flash[:success]).to_not be_nil
    end
  end

  describe "Verify that secrets can be updated by a user" do
    before { secret }

    let(:updated_body){ "updated_body" }
    let(:updated_title){ "updated_title" }

    it "User updates a secret" do
      put secret_path(secret), params: {
        :secret => attributes_for(
          :secret, 
          :title => updated_title,
          :body => updated_body)
      }
      secret.reload

      expect(secret.title).to eq(updated_title)
      expect(secret.body).to eq(updated_body)
    end
  end

  describe "DELETE #destroy" do
    before { secret }  # force let to evaluate

    it "destroys the secret" do
      expect{
        delete secret_path(secret)
      }.to change(Secret, :count).by(-1)
    end

    it "redirects when a secret is deleted" do
      delete secret_path(secret)
      expect(response).to redirect_to secrets_url
    end
  end
end
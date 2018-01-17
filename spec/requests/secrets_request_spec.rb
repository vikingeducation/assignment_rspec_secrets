require 'rails_helper'

describe 'SecretsRequests' do
  let(:secret){ create(:secret) }
  let(:user){ secret.author }

  describe 'GET #index' do
    it "GET #index works as normal" do
      get secrets_path
      expect(response).to be_success
    end
  end #index

  describe 'GET #show' do
    it "GET #show works as normal" do
      get secret_path(secret)
      expect(response).to be_success
    end
  end #show

  describe 'GET #new' do
    it "GET #new redirects to sign in if no current user" do
      get new_secret_path
      expect(response).to redirect_to new_session_path
    end
  end #new

  describe 'POST #create' do
    it "actually creates a post" do
      post session_path, params: { email: user.email, password: user.password }
      expect{
          post secrets_path, params: { secret: attributes_for(:secret), params: {author_id: user.id} }
        }.to change(Secret, :count).by(1)
    end
  end #create

  describe 'GET #edit' do
    it "GET #edit redirects to sign in if no current user" do
      get edit_secret_path(secret)
      expect(response).to redirect_to new_session_path
    end

    it "for another user denies edit access"
  end #edit

end

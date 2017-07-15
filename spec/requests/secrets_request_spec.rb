require 'rails_helper'

describe 'SecretRequests' do

  let(:user){create(:user)}
  let(:secret){create(:secret, author: user)}

  before do
    secret
  end

  describe 'GET #show' do

    it "access the show action for the secret" do
      get secret_path(secret)
      expect(response).to be_success
    end

  end



end

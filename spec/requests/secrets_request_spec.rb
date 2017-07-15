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

  describe "PATCH #edit" do
    it "authorized users can edit their secret" do

    end

    it "unauthorized users cannot edit someone else's secret" do

    end
  end


  describe "DELETE #destroy" do
    it "authorized users can delete their secret" do

    end

    it "unauthorized users cannot delete someone else's secret" do

    end
  end



end

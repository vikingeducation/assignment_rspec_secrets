require 'rails_helper'
require 'pry'

describe 'SecretRequests' do

  let(:user){create(:user)}
  let(:another_user){create(:user)}
  let(:secret){create(:secret, author: user)}
  let(:another_secret){create(:secret, author: another_user)}

  before do
    user
    secret
    another_secret
  end

  describe 'GET #show' do

    it "access the show action for the secret" do
      get secret_path(secret)
      expect(response).to be_success
    end

  end
# ============================================================================
  describe "POST #create" do
    before do
      login_as(user)
    end

    it "proper submission creates a new secret" do
      # post secrets_path, params: { :id => user.id, secret: attributes_for(:secret)}
      # binding.pry
      # expect(response).to be_success
      expect{post secrets_path, params: { secret: attributes_for(:secret, :author_id => user.id) } }.to change(Secret, :count).by(1)
    end

    it "creates a flash message" do
      post secrets_path, params: { :secret => attributes_for(:secret) }
      expect(flash[:success]).to_not be_nil
    end
  end
# ============================================================================
  describe "PATCH #edit" do

    let(:new_title_name){"New Top Secret"}

    before do
      login_as(user)
    end

    context "authorized users can edit their secret" do
      it "edit the secret" do
        patch secret_path(secret), params: {:secret => attributes_for(:secret, :title => new_title_name) }
        secret.reload
        expect(secret.title).to eq(new_title_name)
      end

      it "redirects to the show secret" do
       patch secret_path(secret), params: {:secret => attributes_for(:secret) }
       expect(response).to redirect_to secret_path
      end
    end

    it "unauthorized users cannot edit someone else's secret" do
      RSpec::Expectations.configuration.on_potential_false_positives = :nothing

      expect{ patch secret_path(another_secret), params: {:anoethr_secret => attributes_for(:secret, :title => new_title_name) } }.to raise_error
      expect(response).to have_http_status(302)
    end

  end


  describe "DELETE #destroy" do

    before do
      login_as(user)
    end
    # current_user.secrets.find(params[:id])
    it "authorized users can delete their secret" do
      expect{ delete secret_path(secret)}.to change(Secret, :count).by(-1)
    end

    it "unauthorized users cannot delete someone else's secret" do
      RSpec::Expectations.configuration.on_potential_false_positives = :nothing
      expect{ delete secret_path(another_secret)}.to raise_error
      expect(response).to have_http_status(302)
    end
  end



end

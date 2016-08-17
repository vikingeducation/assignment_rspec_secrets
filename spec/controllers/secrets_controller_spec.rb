require 'rails_helper'

describe SecretsController do 
  describe 'user access' do 
    let(:user){ create(:user) }
    let(:secret){ user.secrets.create(attributes_for(:secret)) }

    before :each do 
      session[:user_id] = user.id
    end

    describe 'get #show' do
      it "renders the :show template for secret" do
        get :show, id: secret.id
        expect(response).to render_template :show
      end
    end
  end

end
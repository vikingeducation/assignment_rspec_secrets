require 'rails_helper'

describe UsersController do 
  describe 'user access' do 
    let(:user){ create(:user) }
    let(:secret){ user.secrets.create(attributes_for(:secret)) }

    before :each do 
      session[:user_id] = user.id
    end

    describe "GET #index" do 
      it "gathers and lists secrets" do 
        secret_a = user.secrets.create(attributes_for(:secret))
        secret_b = user.secrets.create(attributes_for(:secret))
        user.reload
        secret.reload

        expect(assigns(:secrets)).to match_array [secret_a, secret_b]
      end

    end

  end

end
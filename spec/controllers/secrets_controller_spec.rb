require 'rails_helper'

describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user) }

  context 'RESTful secrets actions' do

    before do
      session[:user_id] = user.id
    end

    describe "GET #show" do

      it "sets the right instance variable" do
        get :show, :id => secret.id
        expect(assigns(:secret)).to eq(secret)
      end

      it "should not set a wrong instance variable" do
        secret2 = create(:secret)
        get :show, :id => secret2.id
        expect(assigns(:secret)).to_not eq(secret)
      end

    end

  end

end
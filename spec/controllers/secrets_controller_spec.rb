require 'rails_helper'

describe SecretsController do

  describe 'secrets access' do
    let(:secret) { create(:secret) }

    describe 'GET #show' do

      it "sets the correct instance variable" do

        get :show, id: secret.id
        expect(assigns(:secret)).to eq(secret)
      end


    end
  end
end

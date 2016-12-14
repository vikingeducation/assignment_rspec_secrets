require 'rails_helper'

describe SecretsController do

  describe 'get#show' do

    let(:secret){create(:secret)}

    it 'sets the right instance variable' do
      process :show, params: {id: secret.id}
      expect(assigns(:secret)).to eq(secret)
    end

  end


  


end

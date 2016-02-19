require 'rails_helper.rb'

describe SecretsController do


  describe "GET #show" do
    let(:user) { create(:user) }
    let(:secret) { create(:secret, author: user)}

    it "renders the correct secret properly" do
      get :show, id: secret
      expect(response).to render_template :show
    end
  end

end

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


  describe "POST #create" do

    let(:user) { create(:user) }

    it "can make new secret" do
      post :create, {:secret => attributes_for( :secret )}, { user_id: user.id }
      # new_secret = assigns( :secret ).reload
      expect(response).to redirect_to( secret_path( assigns( :secret ) ) )
    end
  end

end
  
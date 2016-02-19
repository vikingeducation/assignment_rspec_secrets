require 'rails_helper.rb'

describe UsersController do


  describe "POST #create" do
    let(:user) { build(:user) }

    it "renders the correct secret properly" do
      get :show, id: secret
      expect(response).to render_template :show
    end
  end

end

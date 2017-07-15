require 'rails_helper'
require 'pry'

describe 'SessionRequests' do

  let(:user){create(:user)}
  before { user }


  describe "POST #create" do

    it "proper submission creates a new user" do
      login_as(user)
      expect(session[:user_id]).to eq(user.id)
    end


  end

end

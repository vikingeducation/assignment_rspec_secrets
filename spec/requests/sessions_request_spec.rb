# spec/requests/sessions_request.spec.rb
require 'rails_helper'

describe "SessionRequests" do
  describe "Logging In" do
    describe "POST #create" do
      it "sets the correct session variable" do
        user = create(:user)
        login_as(user)

        expect(session[:user_id]).to_not be_nil
        expect(session[:user_id]).to eq(user.id)
      end
    end
  end
end

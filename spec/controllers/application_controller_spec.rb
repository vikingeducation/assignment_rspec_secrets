require 'rails_helper'

describe ApplicationController do

  let(:user){ create(:user) }

  context "user is not signed_in" do
=begin
    Not sure if we can test these because you can't call them with HTTP methods and stuff... You could test them from other RESTFUL methods that call them but that seems wrong.
    describe "sign_in" do
      before do
        get :sign_in, 
      end

      it "sets assigns @current_user" do
        expect(assigns(:current_user)).to eq(user)
      end

    end
=end

  end

end
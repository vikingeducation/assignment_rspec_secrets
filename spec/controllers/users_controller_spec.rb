require 'rails_helper'

describe UsersController do



  describe "POST #create" do

    context "valid input" do
      it "creates a user" do
        expect {
          process :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects to new user's page" do
        process :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(user_path(User.last.id))
      end
    end

    context "invalid input" do
      it "rejects creation" do
        expect {
          process :create, params: { user: attributes_for(:user, password: '1') }
        }.to change(User, :count).by(0)
      end

      it "doesn't redirect to new user's page" do
        process :create, params: { user: attributes_for(:user, password: '1') }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH #update" do

    let(:user) { create(:user) }
    let(:updated_name) { "Newname" }

    before do
      session[:user_id] = user.id
    end

    context "valid input" do
      it "updates the user" do
        process :update, params: { id: user.id, user: attributes_for(:user, name: updated_name) }
        user.reload
        expect(user.name).to eq(updated_name)
      end
    end
  end
end

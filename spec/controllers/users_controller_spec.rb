require 'rails_helper'

describe UsersController do
  let(:secret){ create(:secret) }
  let(:user){ secret.author }
  let(:another){create(:user)}

  before do
    user
  end

  describe "POST #create" do
    context "valid params" do
      it "creates a new user" do
        expect do
          process :create, method: :post, params: {user: attributes_for(:user)}
        end.to change(User, :count).by(1)
      end

      it "redirects to the user show page" do
        process :create, method: :post, params: {user: attributes_for(:user)}

        expect(response).to redirect_to(user_path(User.last))
      end
    end
  end

  context "invalid params" do
    it "does not create a new user" do
      expect do
        process :create, method: :post, params: {user: {email: "", password: ""}}
      end.to_not change(User, :count)

      expect do
        process :create, method: :post, params: {user: {}}
      end.to raise_error(ActionController::ParameterMissing)
    end

    it "renders the new page" do
      process :create, method: :post, params: {user: {email: "", password: ""}}

      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before do
      session[:user_id] = user.id
    end

    context "correct user" do

      it "shows the edit page" do
        process :edit, params: { id: user.id }

        expect(response).to render_template :edit
      end

    end

    context "incorrect user" do

      it "redirects away edit page" do

        process :edit, params: { id: another.id }

        expect(response).to redirect_to(root_path)
      end

    end
  end

  describe "PATCH #update" do
    before do
      session[:user_id] = user.id
    end

    context "correct user" do

      it "updates the user" do
        before_update = user
        process :update, method: :patch, params: { id: user.id, user: { email: "new@email.com", password: "abc123" } }
        user.reload

        expect(user.email).to eq("new@email.com")
        expect(user.name).to eq(before_update.name)

        expect(response).to redirect_to(user_path(user.id))
        expect(flash[:success]).to_not be_nil
      end

    end

    context "incorrect user" do

      it "refuses to update" do
        before_update = another
        process :update, method: :patch, params: { id: another.id, user: { email: "new@email.com", password: "abc123" } }
        another.reload

        expect(before_update).to eq(another)

        expect(response).to redirect_to(root_path)
      end

      it "sets a bad flash" do
        before_update = another
        process :update, method: :patch, params: { id: another.id, user: { email: "new@email.com", password: "abc123" } }
        another.reload

        expect(flash[:error]).to_not be_nil
      end

    end
  end

  describe "POST #destroy" do
    before do
      session[:user_id] = user.id
    end

    context "correct user" do


    end

    context "incorrect user" do

      

    end
  end
end

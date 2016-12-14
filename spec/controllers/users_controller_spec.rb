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

    context "unauthenticated user" do
      it 'redirects away from the edit page' do
        session.destroy
        process :edit, params: { id: user.id }

        expect(response).to redirect_to new_session_path
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

    context "unauthenticated user" do
      it 'does not update the user' do
        session.destroy

        before_update = user
        process :update, method: :patch, params: { id: user.id, user: { email: "new@email.com", password: "abc123" } }
        user.reload

        expect(user).to eq before_update

        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "POST #destroy" do
    before do
      session[:user_id] = user.id
    end

    context "correct user" do
      it 'deletes that user from the database' do
        expect do
          process :destroy, params: { id: user.id }
        end.to change(User, :count).by -1
      end

      it 'redirects to root path' do
        process :destroy, params: { id: user.id }

        expect(response).to redirect_to users_path
      end

      it 'destroys the current session' do
        process :destroy, params: { id: user.id }

        expect( session[:user_id] ).to be_nil
      end
    end

    context "incorrect user" do
      before do
        another
      end

      it 'does note delete the user' do
        expect do
          process :destroy, params: { id: another.id }
        end.not_to change(User, :count)
      end

      it 'redirects to index' do
        process :destroy, params: { id: another.id }

        expect(response).to redirect_to root_path
      end
    end
  end

  context "unauthenticated user" do
    it 'does not destroy the user' do
      session.destroy

      expect do
        process :destroy, params: { id: user.id }
      end.not_to change(User, :count)

      expect(response).to redirect_to new_session_path
    end
  end
end

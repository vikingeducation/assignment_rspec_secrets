require 'rails_helper'

describe 'UsersRequests' do
# RSpec.describe UsersRequests, type: :request do
  describe 'user access' do
    let(:user){ create(:user) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #show' do
      it "GET #show works as normal when logged in" do
        get user_path(user)
        expect(response).to be_success
      end
    end

    describe 'GET #new' do
      it "GET #new works as normal" do
        get new_user_path
        expect(response).to be_success
      end
    end

    describe 'GET #edit' do
      it "GET #edit works as normal" do
        get edit_user_path(user)
        expect(response).to be_success
      end

      it "for another user denies access" do
        another_user = create(:user)
        get edit_user_path(another_user)
        expect(response).to redirect_to root_path
      end
    end #edit

    describe 'POST #create' do
      it "redirects after creating the new user" do
        post users_path, params: {user: attributes_for(:user)}
        expect(response).to have_http_status(:redirect)
      end

      it "actually creates the user" do
        users_count_before = User.all.count
        post users_path, params: {user: attributes_for(:user)}
        users_count_after = User.all.count
        expect(users_count_after - users_count_before).to be == 1
      end

      it "creates a flash notice" do
        post users_path, params: {user: attributes_for(:user)}
        expect(flash[:notice]).to_not be_nil
      end

      xit "sets an auth token cookie" do
        post users_path, params: {user: attributes_for(:user)}
        expect(response.cookies["auth_token"]).to_not be_nil
      end
    end #create

    describe "PATCH #update" do
      before {user}

      context "with valid attributes" do
        let(:updated_name){'updated name'}
        it "actually updates the user" do
          patch user_path(user), params: {user: attributes_for(:user, name: updated_name)}
          user.reload
          expect(user.name).to eq(updated_name)
        end

        it "redirects to the updated user" do
          patch user_path(user), params: {user: attributes_for(:user)}
          expect(response).to redirect_to user_path(user)
        end
      end #valid

      context "with invalid attributes" do
        let(:updated_name){nil}
        it 'displays the form again' do
          patch user_path(user), params: {user: attributes_for(:user, name: updated_name)}
          expect(response).to render_template(:edit)
        end
      end #invalid
    end #update

    describe "DELETE #destroy" do

      before { user }  # force let to evaluate

      it "destroys the user" do
        expect{
          delete user_path(user)
        }.to change(User, :count).by(-1)
      end

      it "redirects to the root" do
        delete user_path(user)
        expect(response).to redirect_to users_url
      end

    end #delete
  end #user access

end #UsersController

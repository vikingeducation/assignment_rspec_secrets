require 'rails_helper'

describe UsersController do

  let(:user) { build(:user) }

  context 'RESTful user actions' do

    before do
      session[:user_id] = user.id
    end

    describe "GET #new" do

      it "works as normal" do
        get :new
        expect(response).to render_template :new
      end

    end

    describe "POST #create" do

      it "proper submission creates a new user" do
        expect{ post :create, user: attributes_for(:user) }.
        to change(User, :count).by(1)
      end

      it "redirects to the user show page" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(user_path(assigns(:user)))
        # user.save
        # expect(request.original_url).to eq(user_url(attributes_for(:user)))
      end

      specify "improper submission does not create a new user"

    end

  end

end
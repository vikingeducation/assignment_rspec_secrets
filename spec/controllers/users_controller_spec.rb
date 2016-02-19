# spec/controllers/users_controller_spec.rb
require 'rails_helper'

describe SecretsController do

  describe 'user access' do
    let(:user){ create(:user) }

    before :each do

      session[:user_id] = user.id

    end


    describe 'GET #show' do
      it "shows secret" do

        get :show, id: secret.id
        expect(assigns(:secret)).to match secret
      end
 
    end

    describe 'GET #new' do
      it "new secret" do

        get :new
        expect(assigns(:secret)).to be_a_new(Secret)
      end
 
    end

    describe 'POST #create' do
      it "creates a secret" do

        expect {post :create, secret: attributes_for(:secret)
               }.to change(Secret, :count).by(1)
      end
 
    end

    describe 'POST #create redirects to show' do
      it "redirects after secret secret" do

        post :create, secret: attributes_for(:secret)
        expect(response).to redirect_to secret_path(assigns(:secret))      
      end
 
    end

    describe 'POST #create creates a flash message for success' do
      it "creates a success flash message" do

        post :create, secret: attributes_for(:secret)
        expect(request.flash[:notice]).to_not be_nil
      end
 
    end

    describe 'POST #create creates a flash message for failure' do
      it "creates a failure flash message" do

        post :create, secret: attributes_for(:secret, body: "x")
        expect(response).to render_template :new
      end
 
    end


    describe 'GET #edit' do
      it "edit secret" do

        secret
     
        get :edit, id: secret.id
        expect(assigns(:secret).id).to eq secret.id
      end
 
    end

   describe 'POST #updates redirects to show' do
      it "redirects after secret update" do

        put :update, id: secret.id, secret: attributes_for(:secret, body: "New Body")
        expect(response).to redirect_to secret_path(assigns(:secret))      
      end
 
    end

   describe 'POST #updates redirects to show' do
      it "redirects after secret update" do

        put :update, id: secret.id, secret: attributes_for(:secret, body: "New Body")
        secret.reload
        expect(secret.body).to eq "New Body"     
      end
 
    end

  end

end

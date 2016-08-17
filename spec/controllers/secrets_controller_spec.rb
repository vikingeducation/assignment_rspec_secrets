require 'rails_helper'

describe SecretsController do 
  let(:user){ create(:user) }
  let(:another_user){ create(:user) }
  let(:secret){ user.secrets.create(attributes_for(:secret)) }
  let(:another_secret){ another_user.secrets.create(attributes_for(:secret)) }

  describe 'get #show' do
    it "renders the :show template for secret" do
      get :show, id: secret.id
      expect(response).to render_template :show
    end
  end

  
  # HAPPY
  context "logged in as user" do 
    before :each do 
      session[:user_id] = user.id
    end

    describe "GET #edit" do 
      it "renders the edit form" do 
        get :edit, id: secret.id
        expect(response).to render_template :edit
      end

      it "sets the right instance variables" do
        get :edit, id: secret.id
        expect(assigns(:secret)).to eq(secret)
      end

    end

    describe "PATCH #update" do 
      context "with valid attributes" do 
        let(:updated_body){"asdfasdfasdfasdfasdfa;lkjsdlfkjalskjdf"}

        before :each do 
          patch :update, id: secret.id, secret: attributes_for(:secret, body: updated_body)
        end

        it "finds the specific secret" do
          expect(assigns(:secret)).to eq(secret)
        end

        it "redirects to the updated secret" do 
          expect(response).to redirect_to secret_path(secret)
        end

        it "actually updates the secret" do
          secret.reload
          expect(secret.body).to eq(updated_body)
        end
      end

      context "with invalid attributes" do 
        it "" do end
      end
    end

    describe "DELETE #destroy" do 
      before { secret }

      it "destroys the secret" do
        expect{
          delete :destroy, id: secret.id
          }.to change(Secret, :count).by(-1)
      end

      it "redirects to the root" do
        delete :destroy, id: secret.id
        expect(response).to redirect_to secrets_path
      end
    end

    describe "POST #create" do

      context "with proper attributes" do 

        it "creates a new secret" do 
          expect do 
            post :create, secret: attributes_for(:secret)
          end.to change(Secret, :count).by(1)
        end

        it "redirects to new secret" do 
          post :create, secret: attributes_for(:secret)
          expect(response).to redirect_to("http://test.host/secrets/1")
        end

        it "sets a flash message" do
          post :create, secret: attributes_for(:secret)
          assert_equal flash[:notice], "Secret was successfully created." 
        end

      end
    end
  end

  #sad
  context "logged in as another user" do
    before :each do 
      session[:user_id] = another_user.id
    end

    describe "GET #edit" do 
      it "doesn't render the edit form for a user that isn't the secret owner" do 
        expect{get :edit, id: secret.id}.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    describe "PATCH #update" do 
      context "with valid attributes" do 
        let(:updated_body){"asdfasdfasdfasdfasdfa;lkjsdlfkjalskjdf"}

        it "doesn't find the specific secret" do
          expect{ patch :update, id: secret.id, secret: attributes_for(:secret, body: updated_body) 
            }.to raise_exception(ActiveRecord::RecordNotFound)
        end

        it "doesn't actually updates the secret" do
          secret.reload
          expect(secret.body).to eq(secret.body)
        end
      end

      context "with invalid attributes" do 
        it "" do end
      end
    end

    describe "DELETE #destroy" do 
      before { secret }

      it "doesn't destroy the secret" do
        expect{
          delete :destroy, id: secret.id
          }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end


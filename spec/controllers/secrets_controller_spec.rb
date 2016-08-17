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

  context "logged in as user" do 

    before :each do 
      session[:user_id] = user.id
    end

    describe "GET #edit" do 
      it "renders the edit form" do 
        get :edit, id: secret.id
        expect(response).to render_template :edit
      end

      it "doesn't render the edit form for a user that isn't the secret owner" do 
        expect{get :edit, id: another_secret.id}.to raise_exception
      end
    end

    describe "PATCH #update" do 
      context "with valid attributes" do 

        let(:updated_body){"asdfasdfasdfasdfasdfa;lkjsdlfkjalskjdf"}

        before :each do 
          put :update, id: secret.id, secret: attributes_for(:secret, body: updated_body)
        end

        it "finds the specific secret" do

          expect(assigns(:secret)).to eq(secret)
        end

        it "redirects to the updated secret" do 

          expect(response).to redirect_to(secret_path(secret))
        end

        it "actually updates the secret" do
          secret.reload
          expect(secret.body).to eq(updated_body)
        end

      end
    end

    describe "DELETE #destroy" do 
      pending
    end
  end
end


require 'rails_helper'

describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user) }

  context 'RESTful secrets actions' do

    before do
      session[:user_id] = user.id
    end

    describe "GET #show" do

      it "sets the right instance variable" do
        get :show, :id => secret.id
        expect(assigns(:secret)).to eq(secret)
      end

      it "should not set a wrong instance variable" do
        secret2 = create(:secret)
        get :show, :id => secret2.id
        expect(assigns(:secret)).to_not eq(secret)
      end

    end

    describe 'GET #edit' do

      it 'sets the right instance variable' do
        get :edit, :id => secret.id
        expect(assigns(:secret)).to eq(secret)
      end

      it 'renders the right page' do
        get :edit, :id => secret.id
        expect(response).to render_template(:edit)
      end

      it 'does not render for a user not owning the secret' do
        secret2 = create(:secret)
        expect{get :edit, id: secret2.id}.to raise_error(ActiveRecord::RecordNotFound)
      end

    end

    describe 'PUT #update' do

      context "secret can be changed by owner" do

        specify 'title can be updated' do
          put :update,  id: secret.id,
                        secret: attributes_for(
                                :secret,
                                title: "new_title")
          secret.reload
          expect(secret.title).to eq("new_title")
        end

        specify 'body can be updated' do
          put :update,  id: secret.id,
                        secret: attributes_for(
                                :secret,
                                body: "this is an updated body")
          secret.reload
          expect(secret.body).to eq("this is an updated body")
        end

        it "redirects to the updated secret" do
          put :update,  id: secret.id,
                        secret: attributes_for(:secret)
          expect(response).to redirect_to(secret_path(assigns(:secret)))
        end

      end

      it 'cannot be changed by a person other than owner' do
        secret2 = create(:secret)
        expect do 
          post :update, id: secret2.id,
                        secret: attributes_for(
                        :secret,
                        title: "new_title")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

    end

  end

end
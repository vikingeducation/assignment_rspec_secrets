require 'rails_helper'

describe SecretsController do

  describe 'secrets access' do
    let(:secret) { create(:secret) }

    describe 'GET #show' do

      it "sets the correct instance variable" do

        get :show, id: secret.id
        expect(assigns(:secret)).to eq(secret)
      end
    end
  end

  context "signed in user" do
    let(:user) { create(:user) }
    before :each do
      session[:user_id] = user.id
      user
    end

    context "user has a secret" do

      let(:another_user){create(:user)}
      let(:user_secret){create(:secret, author: user)}
      let(:other_secret){create(:secret, author: another_user)}


      describe "GET #edit" do
        it "is able to edit a secret that belongs to them" do
          get :edit, :id => user_secret.id
          expect(response).to render_template :edit
        end

        it "is unable to edit a secret that belongs to another" do
          expect{ get :edit, :id => other_secret.id }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      describe "DELETE #destroy" do
        before { user_secret }
        it "is able to destroy a secret that belongs to them" do
          expect{ delete :destroy, :id => user_secret.id }.to change(Secret, :count).by(-1)
          expect(response).to redirect_to(secrets_path)
        end
        it "is unable to destroy a secret that belongs to another" do
          expect{ delete :destroy, :id => other_secret.id }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

end

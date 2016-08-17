require 'rails_helper'

describe SecretsController do

  let(:user) { create(:user) }
  let(:user_secret){create(:secret, author: user)}

  describe 'secrets access' do

    describe 'GET #show' do

      it "sets the correct instance variable" do

        get :show, id: user_secret.id
        expect(assigns(:secret)).to eq(user_secret)
      end
    end
  end

  context "signed in user" do


    before :each do
      session[:user_id] = user.id
      user
    end

    context "user wants to create a secret" do

      describe "GET #create" do

        it "is able to create a new secret when user is logged in" do
          expect {post :create, :secret => attributes_for(:secret)}.to change(Secret, :count).by(1)
          expect(response).to redirect_to secret_path(assigns(:secret))
        end

        describe "user creates a secret" do

          before do
            post :create, :secret => attributes_for(:secret)
          end

          it { should set_flash[:notice]}

        end

      end

    end

    context "user has a secret" do

      let(:another_user){create(:user)}
      let(:other_secret){create(:secret, author: another_user)}

      describe "GET #edit" do

        describe "editing the current user" do
          before { get :edit, :id => user_secret.id }

          it "is able to edit a secret that belongs to them" do
            expect(response).to render_template :edit
          end

          it "sets the proper instance variable" do
            expect(assigns(:secret)).to eq(user_secret)
          end
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

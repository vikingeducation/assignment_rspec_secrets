require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }

  describe 'GET #show' do

    it 'set the right secret' do
      another_secret = create(:secret)
      get :show, id: secret.id

      expect(assigns(:secret)).to eq(secret)
      expect(assigns(:secret)).not_to eq(another_secret)
    end
  end

  describe 'DELETE #destroy' do

    context 'Signed In User' do

      let(:user){ create(:user) }
      before do
        session_sign_in(user)
      end

      it 'should be able to destroy one of their secrets' do 
        secret = create(:secret, author: user)

        expect{
          delete :destroy, id: secret.id
        }.to change(Secret, :count).by(-1)
      end

      it "should not be able to destroy the secret of another user" do
        another_user = create(:user)
        secret = create(:secret, author: another_user)

        expect{
          delete :destroy, id: secret.id
        }.to raise_exception
      end
    end
  end

  describe "POST #create" do

    context "Signed in user" do
      let(:user){ create(:user) }
      before do
        session_sign_in(user)
      end

      it "should create a secret if all attributes are valids" do
        expect{
          post :create, secret: attributes_for(:secret)
          }.to change(Secret, :count).by(1)
      end

      it "should create a flash" do
        post :create, secret: attributes_for(:secret)
        expect(flash["notice"]).to match(/successfully/)
      end

      it "should not create a secret if missing attributes" do
        expect{
          post :create, secret: attributes_for( :secret,
                                                title: "")
        }.to change(Secret, :count).by(0)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user){ create(:user) }
    let(:secret){ create(:secret, author: user) }

    before do 
      secret
      session_sign_in(user)
    end

    context "with valids attributes" do
      let(:updated_title){ "updated_title"}

      it "find the secret" do
        put :update, id: secret.id, 
                     secret: attributes_for(:secret,
                                            title: updated_title)
        expect(assigns(:secret)).to eq(secret)
      end


      it "redirect to the secret show page" do
        put :update, id: secret.id,
                     secret: attributes_for( :secret,
                                             title: updated_title )

        expect(response).to redirect_to secret_path(assigns(:secret))
      end

      it 'update the secret' do
        puts :update, id: secret.id,
                      secret: attributes_for( :secret,
                                              title: updated_title )
        secret.reload
        expect(secret.title).to eq(updated_title)
      end
    end
  end
end
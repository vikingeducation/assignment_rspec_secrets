require 'rails_helper'

describe SecretsController do
  let(:user) { create(:user) }
  let(:other_user) {create(:user)}
  let(:secret) { create(:secret, author: user ) }
  let(:other_secret) { create(:secret, author: other_user)}

  before :each do
    session[:user_id] = user.id
  end

  context "Show" do

    it "sets the instance variable correctly" do
      get :show, id: secret.id

      expect(assigns(:secret)).to eq(secret)
    end

  end

  context "Edit" do

    it "sets the instance variable correctly" do
      get :edit, id: secret.id

      expect( assigns(:secret)).to eq(secret)
    end

  end

  context "Update" do

    it "allows a user to edit a secret" do
      patch :update, id: secret.id, secret: attributes_for(:secret, title: "New Title")

      secret.reload
      expect( secret.title ).to eq("New Title")
    end

    it "doesn't allow the wrong user to edit a secret" do
      expect{ patch :update, id: other_secret.id, secret: attributes_for(:secret, title: "New Title") }.to raise_error
    end
  end

  context "Destroy" do

    it "allows a user to destroy their own secret" do
      secret
      expect{ delete :destroy, id: secret.id }.to change(Secret, :count).by(-1)
    end

    it "doesn't allow a user to destroy another user's secret" do
      other_secret
      expect{ delete :destroy, id: other_secret.id }.to raise_error
    end
  end

  context "Create" do

    it "allows a user to create a secret" do
      expect{ post :create, secret: attributes_for(:secret) }.to change(Secret,:count).by(1)
    end

    it "allows a user to create a secret" do
      post :create, secret: attributes_for(:secret)

      expect( flash[:notice] ).not_to be_nil
    end

  end
end

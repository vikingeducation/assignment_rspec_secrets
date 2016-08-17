require 'rails_helper'

describe SecretsController do
  let(:user) {create(:user, :with_attributes)}
  let(:secret){ create(:secret, :with_attributes, author_id: user.id) }
  let(:user2) {create(:user, :with_attributes, email: "blah@gmail.com")}
  let(:secret2){ create(:secret, :with_attributes, author_id: user2.id) }

   before :each do
     session[:user_id] = user.id
     secret
     secret2
   end

  describe "GET #show" do 
    it "sets the right instance variable for secrets#show" do
      get :show, :id => secret.id
      expect(assigns(:secret)).to eq(secret)
    end
  end

  describe "POST #create" do
    it "creates new secret" do
      expect{post :create, secret: attributes_for(:secret, :with_attributes, author: user)}.to change(Secret, :count).by(1)
    end

    it "creating new secret sets a flash message" do
      post :create, secret: attributes_for(:secret, :with_attributes, author: user)
      expect(flash.notice).to be_present
    end
  end

  describe "DELETE #destroy" do 
    it "authorized user can delete own secret" do
      expect(user.secrets.count).to eq(1)
      expect{delete :destroy, id: secret.id}.to change(Secret, :count).by(-1)
      expect(user.secrets.count).to eq(0)
    end
  end

  describe "GET #edit" do 

    it "authorized user can go to an edit page" do 
      get :edit, :id => secret.id
      expect(response).to render_template :edit
    end

    it "authorized user sets right instance variable" do 
      get :edit, :id => secret.id
      expect(assigns(:secret)).to eq(secret)
    end
  end

  describe "POST #update" do 
    it "authorized user can succesfully update their secret" do 
      put :update, :id => secret.id, secret: attributes_for(:secret, title: "New secret title")
      secret.reload
      expect(secret.title).to eq("New secret title")
    end
  end

end
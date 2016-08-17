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
  end


  describe "POST #update" do 
    it "authorized user can succesfully update their secret" do 

    end
  end

end
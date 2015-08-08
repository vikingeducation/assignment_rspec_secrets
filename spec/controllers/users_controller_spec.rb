require 'rails_helper'

describe SecretsController do

  # describe 'secret instance' do
  let(:secret){create(:secret)}
  let(:user){create(:user)}
  before :each do
    session[:user_id] = user.id 
  end


    describe 'GET #show' do
      it "has secret instance" do
        get :show, :id => secret.id
        expect(assigns(:secret)).to match(secret)
      end
    end

    describe 'GET #new' do 
      it "makes a new secret" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      it "creates a new secret" do
        expect{ post :create, secret: attributes_for(:secret)
        }.to change(Secret, :count).by(1)
      end
    end

    describe 'GET #edit' do
      it "has secret instance" do
        secret.author_id = user.id
        secret.save
        get :edit, :id => secret.id
        expect(assigns(:secret)).to match(secret)
      end
    end    
end

  describe UsersController do
      let(:user){create(:user)}
      #Happy
    context "Proper creation of a user" do
      it 'POST #create' do
        expect{post :create, user:  attributes_for(:user)}.to change(User, :count).by(1)
      end
      #Sad
      it 'POST #create' do
        expect{post :create, user:  { :name => "f", :email => "foo@bar.com", :password => "password"}}.to change(User, :count).by(0)
      end
    end

    context "Authorized user actions" do
      before :each do
        session[:user_id] = user.id 
      end
      #Happy
      it 'GET #edit' do
        get :edit, :id => user.id
        expect(response).to render_template :edit
      end
      #Bad
      it 'GET #edit' do
        new_user = create :user 
        get :edit, :id => new_user.id
        expect(response).to_not render_template :edit
      end

    end

    context "it destroys user if authorized" do
      before :each do
        session[:user_id] = user.id 
      end

      it "DELETE #destroy" do
        expect{
          delete :destroy, :id => user.id}
          .to change(User,:count).by(-1)
      end
      
      it "DELETE #destroy" do
        new_user = create :user 
        expect{
          delete :destroy, :id => new_user.id}
          .to change(User,:count).by(0)
      end
      
    end

    

  end




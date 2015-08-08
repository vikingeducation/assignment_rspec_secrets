require 'rails_helper'

describe SecretsController do

  # describe 'secret instance' do
  let(:secret){create(:secret)}


    describe 'GET #show' do
      it "has secret instance" do
        get :show, :id => secret.id
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




  end




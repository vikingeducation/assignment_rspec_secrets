require 'rails_helper'


describe UsersController do

   
  let(:user) {create(:user)}
  

  describe "post #create" do

    it "properly creates a user" do
      expect {post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
    end

    it "throws an error when passed invalid attributes" do
      expect { post :create, user: attributes_for(:user, password: "")}.to change(User, :count).by(0)
      expect(response).to render_template :new
    end

  end


  context "signed in user" do 
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    before :each do 
      session[:user_id] = user.id
      user
      another_user
    end

    describe "editing a user with the same user id" do

      describe "is editing user details" do
        before { get :edit, :id => user.id }

        it "is redirected to edit template" do
          expect(response).to render_template :edit

        end

        it "sets the proper instance variable" do
          expect(assigns(:user)).to eq(user)
        end
      end

      it "is unable to edit another user" do
        get :edit, :id => another_user.id
        expect(response).to redirect_to(root_path)
      end

    end


    it "can destroy a user with the same user id" do
      expect{ delete :destroy, :id => user.id }.to change(User, :count).by(-1)
    end
    
    it "is unable to destroy a user with a different id" do
      expect{ delete :destroy, :id => another_user.id }.to change(User, :count).by(0)
      expect(response).to redirect_to(root_url)
    end

  end



end
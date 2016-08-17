require 'rails_helper'

describe UsersController do

  let(:user) {create(:user)}

  describe "POST #create" do

    context "valid user" do
      it "properly creates user" do
        expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by (1)
      end
    end

    context "invalid user" do
      it "throws an error" do
        expect { post :create, user: attributes_for(:user, password: "") }.to change(User, :count).by (0)
        expect(response).to render_template :new
      end
    end
  end

  context "signed in user" do
    let(:user) { create(:user) }
    let(:another_user){create(:user)}
    before :each do
      session[:user_id] = user.id
      user
      another_user
    end

    describe "edit a user that is theirs" do
      it "is able to edit a user that is them" do
        get :edit, :id => user.id
        expect(response).to render_template :edit
      end
      it "is unable to edit a user that is another" do
        get :edit, :id => another_user.id
        expect(response).to redirect_to(root_path)
      end
    end
    describe "destroy a user that is theirs" do
      it "is able to destroy a user that is them" do
        expect{ delete :destroy, :id => user.id }.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_path)
      end
      it "is unable to destroy a user that is another" do
        expect{ delete :destroy, :id => another_user.id }.to change(User, :count).by(0)
        expect(response).to redirect_to(root_url)
      end
    end
  end

end

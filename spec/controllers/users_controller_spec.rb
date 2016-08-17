require 'rails_helper'

describe UsersController do

  describe "POST #create" do

    context "valid user" do
      let(:user) {create(:user)}
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
    describe "edit a secret" do
      it "is able to edit a secret that belongs to them" do
      end
      it "is unable to edit a secret that belongs to another" do
      end

    end
    describe "destroy a secret that belongs to user" do
      it "is able to destroy a secret that belongs to them" do
      end
      it "is unable to destroy a secret that belongs to another" do
      end
    end
    describe "edit a user that is theirs" do
      it "is able to edit a user that is them" do
      end
      it "is unable to edit a user that is another" do
      end
    end
    describe "destroy a user that is theirs" do
      it "is able to destroy a user that is them" do
      end
      it "is unable to destroy a user that is another" do
      end
    end
  end

end

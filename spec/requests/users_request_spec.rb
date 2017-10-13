# spec/requests/users_request_spec.rb
require 'rails_helper'

describe "UsersRequests" do
  describe "user creation" do
    describe "POST #create" do
      it "creates a new User with proper params" do
        expect { post users_path, params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
      end

      it "does not create a new User if the provided name is < 3 characters long" do
        expect { post users_path, params: { user: attributes_for(:user, name: "a" * 2) } }.to change(User, :count).by(0)
      end

      it "does not create a new User if the provided name is > 20 characters long" do
        expect { post users_path, params: { user: attributes_for(:user, name: "a" * 21) } }.to change(User, :count).by(0)
      end

      it "does not create a new User if an email address is not provided" do
        expect { post users_path, params: { user: attributes_for(:user, email: nil) } }.to change(User, :count).by(0)
      end

      it "does not create a new User if the provided email address already exists" do
        existing_user = create(:user)

        expect { post users_path, params: { user: attributes_for(:user, email: existing_user.email) } }.to change(User, :count).by(0)
      end

      it "does not create a new User if the provided password is < 6 characters long" do
        expect { post users_path, params: { user: attributes_for(:user, password: "a" * 5) } }.to change(User, :count).by(0)
      end

      it "does not create a new User if the provided password is > 16 characters long" do
        expect { post users_path, params: { user: attributes_for(:user, password: "a" * 17) } }.to change(User, :count).by(0)
      end
    end
  end

  describe "user access" do
  end
end

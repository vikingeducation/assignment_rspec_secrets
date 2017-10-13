# spec/requests/users_request_spec.rb
require 'rails_helper'

describe "UsersRequests" do
  describe "Creating new Users" do
    describe "POST #create" do
      context "Successful User creation" do
        it "creates a new User with proper params" do
          expect { post users_path, params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
        end

        it "redirects after creating the new User" do
          post users_path, params: { user: attributes_for(:user) }
          expect(response).to have_http_status(:redirect)
        end
      end

      context "Unsuccessful User creation" do
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
  end

  describe "Making changes to User accounts" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    before do
      user
      another_user
      login_as(user)
    end

    describe "GET #edit" do
      it "redirects the User to the root URL if he attempts to edit another User's account" do
        get edit_user_path(another_user)

        expect(response).to redirect_to(root_url)
      end

      it "returns a successful response if a User edits his own account" do
        get edit_user_path(user)
        expect(response).to be_success
      end
    end

    describe "PATCH #update" do
      context "valid changes" do
        it "saves changes to the User's account with proper params" do
          updated_name = "Bruce Wayne"
          updated_email = "bruce@wayne.com"

          patch user_path(user), params: { user: attributes_for(:user, name: updated_name, email: updated_email) }

          user.reload
          expect(user.name).to eq(updated_name)
          expect(user.email).to eq(updated_email)
        end

        it "redirects to the User's show page if the provided password and password confirmation match" do
          updated_password = "Iambatman"

          patch user_path(user), params: { user: attributes_for(:user, password: updated_password, password_confirmation: updated_password) }

          expect(response).to redirect_to(user_path(user))
        end
      end

      context "invalid changes" do
        it "does not save changes to the User's account if the new name is < 3 characters long" do
          updated_name = "a" * 2

          patch user_path(user), params: { user: attributes_for(:user, name: updated_name) }

          user.reload
          expect(user.name).not_to eq(updated_name)
        end

        it "does not save changes to the User's account if the new name is > 20 characters long" do
          updated_name = "a" * 21

          patch user_path(user), params: { user: attributes_for(:user, name: updated_name) }

          user.reload
          expect(user.name).not_to eq(updated_name)
        end

        it "does not save changes to the User's account if the new email address is empty" do
          updated_email = ""

          patch user_path(user), params: { user: attributes_for(:user, email: updated_email) }

          user.reload
          expect(user.email).not_to eq(updated_email)
        end

        it "does not save changes to the User's account if the new email address already exists" do
          patch user_path(another_user, params: { user: attributes_for(:user, email: user.email) })

          another_user.reload
          expect(another_user.email).not_to eq(user.email)
        end

        it "does not redirect to the User's show page if the new password is < 6 characters long" do
          updated_password = "a" * 5

          patch user_path(user), params: { user: attributes_for(:user, password: updated_password, password_confirmation: updated_password) }

          expect(response).not_to redirect_to(user_path(user))
        end

        it "does not redirect to the User's show page if the new password is > 16 characters long" do
          updated_password = "a" * 17

          patch user_path(user), params: { user: attributes_for(:user, password: updated_password, password_confirmation: updated_password) }

          expect(response).not_to redirect_to(user_path(user))
        end
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the root URL if a User attempts to delete another User's account" do
        delete user_path(another_user)

        expect(response).to redirect_to(root_url)
      end

      it "allows a User to delete his own account" do
        expect { delete user_path(user) }.to change(User, :count).by(-1)
      end

      it "redirects to the Users index page upon a successful User account deletion" do
        delete user_path(user)
        expect(response).to redirect_to(users_path)
      end
    end
  end
end

# spec/requests/secrets_request_spec.rb
require 'rails_helper'

describe "SecretsRequests" do
  let(:secret) { create(:secret) }
  let(:author) { secret.author }

  # login before each spec
  before :each do
    secret
    login_as(author)
  end

  describe "Viewing Secrets" do
    describe "GET #show" do
      it "returns a successful response when the User is logged in" do
        get secret_path(secret)
        expect(response).to be_success
      end

      it "returns a successful response when the User is logged out" do
        delete session_path
        get secret_path(secret)
        expect(response).to be_success
      end
    end
  end

  describe "Editing Secrets" do
    describe "GET #edit" do
      it "successfully renders the Secret's edit page" do
        get edit_secret_path(secret)
        expect(response).to be_success
      end
    end

    describe "PATCH #update" do
      context "valid changes" do
        it "saves changes to the Secret with proper params" do
          updated_title = "New secret title"
          updated_body =  "New secret body"

          put secret_path(secret), params: { secret: attributes_for(:secret, title: updated_title, body: updated_body) }

          secret.reload
          expect(secret.title).to eq(updated_title)
          expect(secret.body).to eq(updated_body)
        end

        it "redirects back to the Secret's show page" do
          updated_title = "New secret title"
          updated_body =  "New secret body"

          put secret_path(secret), params: { secret: attributes_for(:secret, title: updated_title, body: updated_body) }

          expect(response).to redirect_to(secret_path(secret))
        end
      end

      context "invalid changes" do
        it "does not save changes to the Secret if the title is < 4 characters long" do
          updated_title = "a" * 3

          put secret_path(secret), params: { secret: attributes_for(:secret, title: updated_title) }

          secret.reload
          expect(secret.title).not_to eq(updated_title)
        end

        it "does not save changes to the Secret if the title is > 24 characters long" do
          updated_title = "a" * 25

          put secret_path(secret), params: { secret: attributes_for(:secret, title: updated_title) }

          secret.reload
          expect(secret.title).not_to eq(updated_title)
        end

        it "does not save changes to the Secret if the body is < 4 characters long" do
          updated_body = "a" * 3

          put secret_path(secret), params: { secret: attributes_for(:secret, body: updated_body) }

          secret.reload
          expect(secret.body).not_to eq(updated_body)
        end

        it "does not save changes to the Secret if the body is > 140 characters long" do
          updated_body = "a" * 141

          put secret_path(secret), params: { secret: attributes_for(:secret, body: updated_body) }

          secret.reload
          expect(secret.body).not_to eq(updated_body)
        end
      end
    end
  end

  describe "Deleting Secrets" do
    describe "DELETE #destroy" do
      it "allows a User to delete his own Secret" do
        expect { delete secret_path(secret) }.to change(Secret, :count).by(-1)
      end

      it "redirects back to the Secrets index page" do
        delete secret_path(secret)
        expect(response).to redirect_to(secrets_path)
      end
    end
  end
end

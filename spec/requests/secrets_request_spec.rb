require "rails_helper"

describe "SecretsRequest" do
  let(:user){ create(:user) }
  let(:secret){ create(:secret, author: user)}

  describe "POST #create" do
    context "proper submission" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
      end

      it "creates a new secret for a logged in user" do
        expect{
          post secrets_path, params: {secret: attributes_for(:secret, author: user)}
        }.to change(Secret, :count).by(1)
      end

      it "redirects after creating the secret" do
        post secrets_path, params: {secret: attributes_for(:secret, author: user)}
        expect(response.code.to_i).to be 302
      end

      it "sets a flash message" do
        post secrets_path, params: {secret: attributes_for(:secret, author: user)}
        expect(flash[:success]).not_to be nil
      end
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get secret_path(secret.id)
      expect(response.code.to_i).to be 200
    end
  end

  describe "GET #edit" do
    context "proper access" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
      end

      it "allows access to the secret's owner" do
        get edit_secret_path(secret.id)
        expect(response.code.to_i).to be 200
      end
    end

    context "improper access" do
      let(:other_secret){ create(:secret) }

      it "redirects someone who is not logged in to the login page" do
        get edit_secret_path(secret.id)
        expect(response.code.to_i).to be 302
      end

      it "fails to someone who is not the secret's owner" do
        ## login
        post session_path, params: {email: user.email, password: user.password}
        ## try to access someone else's secret
        expect{
          get edit_secret_path(other_secret.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #update" do
    let(:new_title){ "new title" }

    context "proper access" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
      end

      it "allows the secret's owner to update the secret" do
        secret_attrs = attributes_for(:secret, title: new_title, author: user)
        put secret_path(secret.id), params: {secret: secret_attrs}
        secret.reload
        expect(secret.title).to eq(new_title)
      end
    end

    context "improper access" do

      it "redirects someone who is not logged in to the login page" do
        secret_attrs = attributes_for(:secret, title: new_title, author: user)
        put secret_path(secret.id), params: {secret: secret_attrs}
        expect(response.code.to_i).to be 302
      end

      it "fails to someone who is not the secret's owner" do
        ## login
        post session_path, params: {email: user.email, password: user.password}
        ## try to edit someone else's secret
        another_secret = create(:secret)
        expect{
          put secret_path(another_secret.id), params: {secret: attributes_for(:secret, author: user)}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end

  describe "DELETE #destroy" do
    before{ secret }
    context "proper access" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
      end

      it "allows the secret's owner to destroy the secret" do
        expect{
          delete secret_path(secret.id)
        }.to change(Secret, :count).by(-1)
      end
    end

    context "improper access" do

      it "redirects someone who is not logged in to the login page" do
        delete secret_path(secret.id)
        expect(response.code.to_i).to be 302
      end

      it "fails to someone who is not the secret's owner" do
        another_secret = create(:secret)
        ## login
        post session_path, params: {email: user.email, password: user.password}
        ## try to delete someone else's secret
        expect{
          delete secret_path(another_secret.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end

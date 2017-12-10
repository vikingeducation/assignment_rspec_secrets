# # spec/requests/users_request_spec.rb
require 'rails_helper'

describe 'UsersRequests' do
  let(:user){ create(:user) }
  let(:secret){ create(:secret) }

  # LOGIN a http request directly to the session controller
  # # # This will work for session or cookie-based auth
  before :each do 
    post session_path, params: { email: user.email, password: user.password }
  end

  describe 'Users' do
    it "Verify that a proper submission will create a new User" do
      get user_path(user)
      expect(response).to be_success
    end

    it "actually creates the user" do
      expect{
        post users_path, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
    end

    it "Verify that an improper submission will not create a new User" do
      expect{
        get users_path, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(0)
    end

    it "creates a flash message" do
      post users_path, params: { :user => attributes_for(:user) }
      expect(flash[:success]).to_not be_nil
    end
  end

  describe 'GET #edit' do
    it "GET #edit works as normal" do
      get edit_user_path(user)
      expect(response).to be_success
    end
  end

  describe 'Secrets' do
    it "Verify that secrets #show returns a successful response. " do
      get secret_path(secret)
      expect(response).to be_success
    end

    it "Secret is created" do
    expect{
        post secrets_path, params: { secret: attributes_for(:secret) }
      }.to change(Secret, :count).by(1)
    end

    it "Verify that this Secret creation sets a flash message." do
      post secrets_path, params: { :secret => attributes_for(:secret) }
      expect(flash[:success]).to_not be_nil
    end


  end

  describe "Verify that secrets can be updated by a user" do
    before { secret }

    let(:updated_body){ "updated_body" }

    it "User updates a secret" do
      put secret_path(secret), params: {
        :secret => attributes_for(
          :secret, 
          :body => updated_body)
      }
      secret.reload
      expect(secret.body).to eq(updated_body)
    end
  end

  describe "Verify that authorized users can perform actions they should be able to like #update" do
    before { user }

    context "with valid attributes" do
      let(:updated_name){ "updated_foo" }

      it "actually updates the user" do
        put user_path(user), params: {
          :user => attributes_for(
            :user, 
            :name => updated_name)
        }
        # This won't work properly if you don't reload!!!
        # The user in that case would be the same one
        # you set in the `let` method
        user.reload
        expect(user.name).to eq(updated_name)
      end
    end
  end

  describe "DELETE #destroy" do

    before { secret }  # force let to evaluate

    it "destroys the secret" do
      expect{
        delete secret_path(secret)
      }.to change(Secret, :count).by(-1)
    end

    it "redirects when a secret is deleted" do
      delete secret_path(secret)
      expect(response).to redirect_to secrets_url
    end
  end
end


# # Verify that authorized users can perform actions they should be able to like editing or destroying a secret which belongs to them or editing/destroying a User account that is theirs. Note: Some scenarios may result in controller actions deliberately throwing errors... so test it!
# # Verify the opposite sad paths for each happy path.
# # Verify that a proper submission (and logged in user) will create a Secret.
# # Verify that sessions#create sets the right session variable.

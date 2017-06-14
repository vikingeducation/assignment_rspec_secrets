require "rails_helper"

describe "UsersRequest" do

  describe "POST #create" do
    it "creates a new user if valid" do
      expect{
        post users_path, params: {user: attributes_for(:user)}
      }.to change(User, :count).by(1)
    end

    it "re-renders the form if invalid" do
      post users_path, params: {user: {name:nil, email:nil, password:nil, password_confirmation:nil}}
      expect(response.code.to_i).to be 200
    end
  end

  describe "POST sessions#create" do
    it "sets the right session variable" do
      user = create(:user)
      post session_path, params: {email: user.email, password: user.password}
      expect(session[:user_id]).to eq(user.id)
    end
  end

end

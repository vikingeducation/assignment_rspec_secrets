require 'rails_helper'

describe "secrets/index.html.erb" do

  let(:user){create(:user)}
  context "Non-authorized user" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "doesn't show author" do
      secret = create(:secret)
      secrets = [secret, create(:secret)]
      assign(:secrets, secrets)
  
      render
      expect(rendered).to match /hidden/
    end
  end

  context "Authorized user" do
    before do
      def view.signed_in_user?
        true
      end
    end

    it "can see the authors" do
      secret = create(:secret)
      secrets = [secret, create(:secret)]
      assign(:secrets, secrets)
  
      render
      expect(rendered).to match ("#{secret.author.name}")
    end
  end

end

describe "shared/_navigation.html.erb" do
  let(:user){create(:user)}
    before do
      def view.current_user
        @user
      end
    end
  context "Authorized user" do
    before do
      @user=user
      def view.signed_in_user?
        true
      end
    end

    it "can Logout link" do
      secret = create(:secret)
      secrets = [secret, create(:secret)]
      assign(:secrets, secrets)
      
      render
      expect(rendered).to match (/Logout/)
    end
  end

  context "Non-authorized user" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "can see Login link" do
      render
      expect(rendered).to match ("Login")
    end
  end
end

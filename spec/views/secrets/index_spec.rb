require 'rails_helper'

describe "secrets/index.html.erb" do

  context "logged in user" do
    let(:user){ create(:user) }

    before do
      def view.signed_in_user?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it "shows the authors of secrets" do
      secret = create(:secret)
      secrets = [secret, create(:secret)]
      assign(:secrets, secrets)
      render

      expect(rendered).not_to have_content("**hidden**")
    end
  end

  context "not logged in user" do

    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end

    it "hides the authors of secrets" do
      secret = create(:secret)
      secrets = [secret, create(:secret)]
      assign(:secrets, secrets)
      render

      expect(rendered).to have_content("**hidden**", count: 2)
    end
  end
end
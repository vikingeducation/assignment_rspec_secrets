require 'rails_helper'

describe "secrets/index.html.erb" do

  context "user is not signed in" do
    before do
      def view.current_user
        nil
      end

      def view.signed_in_user?
        false
      end
    end

    it "does not show user names" do
      secrets = [create(:secret)]

      assign(:secrets, secrets)

      render

      expect(rendered).to match /<td>\*\*hidden\*\*<\/td>/
    end

    it "says login" do
      secrets = [create(:secret)]

      assign(:secrets, secrets)

      render

      expect(rendered).to match /Login/
    end
  end

  context "user is signed in" do
    before do
      def view.current_user
        nil
      end

      def view.signed_in_user?
        true
      end
    end

    it "shows user names" do
      secrets = [create(:secret)]

      assign(:secrets, secrets)

      render

      expect(rendered).to match /<td>#{secrets[0].author.name}<\/td>/
    end
  end

end
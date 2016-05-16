require 'rails_helper'

describe "shared/_navigation.html.erb" do

  let(:user){ create(:user) }

  context "user is signed in" do
    before do
      @user = user
      def view.current_user
        @user
      end

      def view.signed_in_user?
        true
      end
    end

    it "shows a link to logout" do
      render

      expect(rendered).to match /Logout/
    end
  end

  context "user is not signed in" do

    before do
      def view.signed_in_user?
        false
      end
    end

    it "shows a link to login" do
      render

      expect(rendered).to match /Login/
    end
  end
end
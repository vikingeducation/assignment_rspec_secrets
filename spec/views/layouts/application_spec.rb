# spec/views/layouts/application_spec.rb
require 'rails_helper'

describe "layouts/application.html.erb" do
  context "When a User is logged out" do
    it "displays a Login link in the navbar" do
      render
      expect(rendered).to have_link("Login")
    end
  end

  context "When a User is logged in" do
    before do
      @user = create(:user)

      # override view helper methods
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end

    it "displays a Logout link in the navbar" do
      render
      expect(rendered).to have_link("Logout")
    end
  end
end

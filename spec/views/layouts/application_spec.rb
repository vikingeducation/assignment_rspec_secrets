require 'rails_helper'


describe "layouts/application.html.erb" do

  context "when logged in" do

    before do
      assign(:user, create(:user))
      assign(:secrets ,create_list(:secret, 5))
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
    end

    it "shows Logout link" do
      render
      expect(rendered).to have_link("Logout")
    end
  end

  context "when not logged in" do
    before do
      def view.signed_in_user?
        false
      end
      def view.current_user
        nil
      end
    end

    it "does not show Logout link" do
      render
      expect(rendered).to_not have_link("Logout")
    end
  end

end

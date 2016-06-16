require 'rails_helper'


describe "layouts/application.html.erb" do

  context "Signed in" do
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

    it "should see a logout link" do
      render
      expect(rendered).to match /Logout/
    end
  end

  context "Not signed in" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "should see a Login link" do
      render
      expect(rendered).to match /Login/
    end
  end
end
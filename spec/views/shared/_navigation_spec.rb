require 'rails_helper'

describe "shared/_navigation.html.erb" do

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

    it "shows logout link" do
      render

      expect(rendered).to have_selector("a[href=\"#{session_path}\"]", :text => "Logout")
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

    it "shows log in link" do
      render

      expect(rendered).to have_selector("a[href=\"#{new_session_path}\"]", :text => "Login")
    end
  end
end
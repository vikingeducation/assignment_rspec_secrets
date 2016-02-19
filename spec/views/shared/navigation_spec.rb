require 'rails_helper'

describe "shared/_navigation.html.erb" do

  context "visitor" do

    before do

      def view.signed_in_user?
        false
      end

      def view.current_user
        false
      end

    end

    it "cannot see logout link" do
      render
      expect(rendered).to_not match "Logout"
    end
  end

  context "logged in user" do

    before do

      @user = create( :user )

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

    end

    it "can see logout link" do
      render
      expect(rendered).to match "Logout"
    end
  end

end

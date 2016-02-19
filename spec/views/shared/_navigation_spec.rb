require 'rails_helper'

describe 'shared/_navigation.html.erb' do

  let(:user) { create(:user) }

  describe "logged in users" do

    before :each do

      def view.signed_in_user?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it "shows a Logout button" do
      render
      expect(rendered).to have_content("Logout")
    end

  end

  describe "logged out users" do

    before :each do
      def view.signed_in_user?
        false
      end
    end

    it "shows a Login button" do
      render
      expect(rendered).to have_content("Login")
    end
  end

end
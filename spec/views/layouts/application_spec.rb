require 'rails_helper'

describe 'layouts/application' do

  let(:user){create(:user)}

  before do
    assign(:user, user)
  end


  context "the user is logged-in" do
    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end
    it "User sees a 'Logout' link" do
      render
      expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    end
  end

  context "the user is NOT logged-in" do
    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end
    it "User cannot see a 'Logout' link" do
      render
      expect(rendered).not_to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    end
  end

end

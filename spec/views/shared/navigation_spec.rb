require 'rails_helper'
describe 'shared/navigation.html.erb' do
  let(:users) { create_list(:user, 5) }
  before do
    assign(:users, users)
    @users = users
  end
  context "a logged out user" do
    before do
      def view.signed_in_user?
        false
      end
      def view.current_user
        nil
      end
    end
    it "should have a 'Login' link" do
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to match(/Login/)
    end
  end
  context "a logged in user" do
    before do
      def view.signed_in_user?
        true
      end
      def view.current_user
        @users.first
      end
    end
    it "should have a 'Logout' link" do
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to match(/Logout/)
    end
  end
end
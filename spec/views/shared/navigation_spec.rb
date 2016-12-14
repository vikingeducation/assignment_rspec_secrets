require 'rails_helper'

describe 'shared/_navigation.html.erb' do
  let(:user){ create(:user) }
  before do
    @user = user
    def view.current_user
      @user
    end

  end

  describe "visitor" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "hides the logout link" do
      @secrets = [create(:secret)]
      render
      expect(rendered).to_not have_content("Logout")
    end

  end

  describe "user" do
    before do
      def view.signed_in_user?
        true
      end
    end

    it "shows the logout link" do
      session[:user_id] = @user.id
      @secrets = [create(:secret, author: @user)]
      render
      expect(rendered).to have_content("Logout")
    end

  end

end

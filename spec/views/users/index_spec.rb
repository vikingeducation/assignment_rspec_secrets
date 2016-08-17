require 'rails_helper'

describe "users/index.html.erb" do

  let(:user) {create(:user, :with_attributes)}

  context "user logged in "
    before do
      @user = user

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

    end

    it "shows the logout link" do 
      @users = [@user]
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to match(/Logout/)
    end
  end

  context "user not logged in" do 
    
    before do 
      @user = create(:user, :with_attributes)
      def view.signed_in_user?
        false
      end

      def view.current_user
        false
      end  
    end

    it "will not show logout" do 
      @users = [@user]
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to_not match(/Logout/)
    end

end
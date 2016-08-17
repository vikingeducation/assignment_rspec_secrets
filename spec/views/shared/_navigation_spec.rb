require 'rails_helper'

describe 'shared/_navigation.html.erb' do
  let(:user){ create(:user) }

  context 'logged in user' do

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
      expect(rendered).to have_content("Logout")
    end

  end

  context 'logged out user' do
     before do
      
      def view.signed_in_user?
        false
      end

       def view.current_user
        false
      end

    end

    it "shows login link" do
      render
      expect(rendered).to have_content("Login")
    end

  end

end
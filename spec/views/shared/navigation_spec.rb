require 'rails_helper'

describe 'shared/_navigation.html.erb' do

  context 'logged in user' do
    before do
      @user = create(:user)
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end

    it 'should show a logout link for a logged in user' do
      render
      expect(response).to match("Logout")
    end
  end


  context 'logged out user' do
    before do
      def view.signed_in_user?
        false
      end
    end

    it 'should show a login link for a logged out user' do
      render
      expect(response).to match("Login")
    end
  end
end

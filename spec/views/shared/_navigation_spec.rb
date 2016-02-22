require 'rails_helper'

describe 'shared/_navigation.html.erb' do
  let(:user){ create(:user) }
  let(:secret){ create(:secret, author: user) }

  before do
    user
    secret

    # @user = user
    def view.current_user
      @user
    end
  end

  context 'user logged in' do
    before do
      def view.signed_in_user?
        true
      end
    end

    it 'logged in user sees logout link' do
      assign(:user, user)
      render
      expect(render).to match("Logout")
    end
  end

  context 'user logged out' do
    before do
      def view.signed_in_user?
        false
      end
    end

    it 'logged out user sees login link' do
      assign(:user, user)
      render
      expect(render).to match("Login")
    end
  end
end
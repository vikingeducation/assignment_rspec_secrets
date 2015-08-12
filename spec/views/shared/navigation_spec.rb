require 'rails_helper'

describe 'shared/_navigation.html.erb' do

  context 'when not logged in' do

    before do
      def view.current_user
        nil
      end

      def view.signed_in_user?
        false
      end
    end


    it 'shows the Login link' do
      render
      expect(rendered).to match("Login")
      expect(rendered).not_to match("Logout")
    end
  end


  context 'when logged in' do
    let(:user) { create(:user) }

    before do
      @user = user

      def view.current_user
        @user
      end

      def view.signed_in_user?
        true
      end
    end

    it 'shows the Logout link' do
      render
      expect(rendered).not_to match("Login")
      expect(rendered).to match("Logout")
    end

  end

end
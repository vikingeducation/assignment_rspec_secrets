require 'rails_helper'

describe 'layouts/application' do
  context 'not logged in' do

    before do

      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end

    end

    it 'shows log in link' do

      render

      expect(rendered).to match 'Login'

    end
  end

  context 'logged in' do

    before do

      @user = create(:user)

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

    end

    it 'shows log out link' do

      render

      expect(rendered).to match 'Logout'

    end
  end
end

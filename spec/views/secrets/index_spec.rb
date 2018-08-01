require 'rails_helper'

describe 'secrets/index.html.erb' do

  context 'when user is logged in' do

    before do
      assign(:user, create(:user))
      assign(:secrets ,create_list(:secret, 5))
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
    end

    it 'it shows authors names' do
      render
      expect(rendered).to_not have_text('hidden')
    end

  end

  context 'when user is not logged in' do

    before do
      assign(:user, create(:user))
      assign(:secrets, create_list(:secret, 5))
      def view.signed_in_user?
        false
      end
      def view.current_user
        nil
      end
    end

    it 'shows authors names as **hidden**' do
      render
      expect(rendered).to have_text('hidden')
    end

  end


end

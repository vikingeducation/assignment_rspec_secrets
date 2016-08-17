require 'rails_helper'

describe 'secrets/index.html.erb' do
  context 'not logged in' do
    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        false
      end
    end
    scenario 'user cannot see author of a secret' do
      user = create(:user)
      secret = create(:secret)

      assign(:secrets, [secret])

      render

      expect(rendered).to have_content('**hidden**')
    end
  end

  context 'logged in' do
    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        false
      end
    end

    scenario 'user can see author' do
      user = create(:user)
      secret = create(:secret)

      assign(:secrets, [secret])

      render

      expect(rendered).to_not have_content('**hidden**')
    end
  end

  
end

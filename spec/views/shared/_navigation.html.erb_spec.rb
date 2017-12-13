require 'rails_helper'

RSpec.describe 'shared/_navigation', type: :view do
  describe 'seeing the logout link' do
    context 'logged in user' do
      before do
        def view.signed_in_user?
          true
        end

        def view.current_user
          @user
        end
      end

      it 'shows the logout link' do
        user = create :user
        assign(:user, user)

        render
        expect(rendered).to match /Logout/
      end
    end

    context 'not logged in user' do
      before do
        def view.signed_in_user?
          false
        end

        def view.current_user
          @user
        end
      end

      it 'hides the logout link' do
        user = create :user
        assign(:user, user)

        render
        expect(rendered).not_to match /Logout/
      end
    end
  end
end

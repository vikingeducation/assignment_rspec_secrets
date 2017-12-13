require 'rails_helper'

RSpec.describe 'secrets/show', type: :view do
  describe 'seeing the author name' do
    context 'logged in user' do
      before do
        def view.signed_in_user?
          true
        end

        def view.current_user
          @user
        end
      end

      it 'shows the author of the secrets' do
        secret = create :secret

        assign(:secret, secret)
        assign(:user, secret.author)
        render

        expect(rendered).to match secret.author.name
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

      it 'hides the secrets\'s author' do
        secret = create :secret

        assign(:secret, secret)
        assign(:user, nil)
        render

        expect(rendered).to match /\*\*hidden\*\*/
      end
    end
  end
end

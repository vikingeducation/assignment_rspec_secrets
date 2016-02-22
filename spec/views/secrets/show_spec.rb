require 'rails_helper'

describe 'secrets/show.html.erb' do
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

    it 'logged in user can see secret author' do

      assign(:user, user)
      assign(:secret, secret)
      render
      expect(rendered).to match("#{secret.author.name}")
    end
  end

  context 'user logged out' do
    before do
      def view.signed_in_user?
        false
      end
    end

    it 'logged out user cannot see secret author' do
      assign(:user, user)
      assign(:secret, secret)
      render
      expect(rendered).not_to match("#{secret.author.name}")
    end
  end
end
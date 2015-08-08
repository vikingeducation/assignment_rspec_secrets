require 'rails_helper'

describe 'secrets/index.html.erb' do
  let(:secret){ create(:secret) }
  let(:user){ create(:user) }

  context 'no signed in user' do
    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        false
      end
    end

    it 'should not show author names if no logged in user' do
      secrets = create_list(:secret, 3)
      assign(:secrets, secrets)

      render

      expect(rendered).to match('hidden')
    end

  end

  context 'signed in user' do
    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        true
      end
    end

    it 'should not show author names if no logged in user' do
      secrets = create_list(:secret, 3)
      assign(:secrets, secrets)

      render

      expect(rendered).to match(secrets.first.author.name)
    end

  end


end

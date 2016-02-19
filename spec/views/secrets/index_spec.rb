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

    it 'does not show the author names' do

      secrets = create_list(:secret, 3)

      assign(:secrets, secrets)


      render

      expect(rendered).to match /\*\*hidden\*\*/
    end

  end


  context 'logged in' do

    before(:each) do
      @user = create(:user)

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end


    it 'does not show the author names' do

      secrets = create_list(:secret, 3, author: @user)

      assign(:secrets, secrets)

      render

      expect(rendered).to match @user.name
    end

  end
end

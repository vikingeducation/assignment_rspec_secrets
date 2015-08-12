require 'rails_helper'

describe 'secrets/show.html.erb' do

  let(:secret) { create(:secret) }
  before do
    assign(:secret, secret)
  end

  context 'when not logged in' do

    before do
      def view.current_user
        nil
      end

      def view.signed_in_user?
        false
      end
    end


    it 'hides the author name' do
      render
      expect(rendered).to match("hidden")
      expect(rendered).not_to match(secret.author.name)
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


    it 'shows the author name' do
      render
      expect(rendered).not_to match("hidden")
      expect(rendered).to match(secret.author.name)
    end

  end

end
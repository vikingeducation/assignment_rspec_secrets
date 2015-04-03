require 'rails_helper'

describe 'secrets/index.html.erb' do
  before do
    assign(:secrets, [create(:secret)]*2 )
  end
  context 'when a user is not logged in' do
    before do
      def view.signed_in_user?
	false
      end
      def view.current_user
	nil
      end
    end
    specify 'they cannot see the author of a secret' do
      render
      expect(rendered).to match(/hidden/) 
    end
  end
  context 'when a user is logged in' do
    let(:author_name){ create(:secret).author.name }
    before do
      def view.signed_in_user?
	true
      end
      def view.current_user
        FactoryGirl.create(:user)
      end
    end
    specify 'they see the author of a secret' do
      render
      expect(rendered).to match("<td>#{author_name}</td>")
    end
  end
end

describe 'shared/_navigation.html.erb' do
  context 'when a user is not logged in' do
    before do
      def view.signed_in_user?
	false
      end
      def view.current_user
	nil
      end
    end
    specify 'they see a Log In link' do
      render
      expect(rendered).to match('<a href="/session/new">Login</a>')
    end
  end
  context 'when a user is logged in' do
    before do
      def view.signed_in_user?
	true
      end
      def view.current_user
        FactoryGirl.create(:user)
      end
    end
    specify 'they see a Log Out link' do
      render
      expect(rendered).to match('<a data-method="delete" href="/session" rel="nofollow">Logout</a>')
    end
  end
end

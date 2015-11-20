require 'rails_helper'

describe 'secrets/index.html.erb' do
  let(:user){create(:user)}
  let(:users){[user, create(:user)]}
  let(:secrets){[create(:secret, :author => user), create(:secret)]}

  before do
    view.extend(ViewHelper)
    assign(:users, users)
    assign(:secrets, secrets)
  end

  context 'the user is logged in' do
    it 'shows the author of all secrets' do
      login(user)
      render
      expect(rendered).to_not have_content(hidden_text)
    end
  end

  context 'the user is logged out' do
    it 'does not show any author of any secrets' do
      render
      expect(rendered).to have_content(hidden_text)
    end
  end
end


require 'rails_helper'
require_relative '../../support/helper_methods'
include HelperMethods

describe 'secrets/index.html.erb' do
  let(:user){ create(:user)}
  let(:secret){ create(:secret, author: user)}
  context 'logged out' do
    it 'does not show author for non-logged-in user' do
      secrets = create_list(:secret, 5)
      assign(:secrets, secrets)
      render
      expect(rendered).to have_content('**hidden**')
    end
  end
  context 'logged in' do
    before do
      assign(:current_user, user)
      assign(:secrets, create_list(:secret, 5, author: user))
    end
    it 'shows author for logged in user' do
      render
      expect(rendered).to have_content(user.name)
    end
  end
end

require 'rails_helper'
require_relative '../../support/helper_methods'
include HelperMethods

describe 'layouts/application.html.erb' do
  let(:user){ create(:user)}
  let(:secret){ create(:secret, author: user)}
  context 'logged out' do
    it 'shows login link' do
      render
      expect(rendered).to have_content('Login')
    end
  end
  context 'logged in' do
    before do
      assign(:current_user, user)
    end
    it 'shows logout link' do
      render
      expect(rendered).to have_content('Logout')
    end
  end


end

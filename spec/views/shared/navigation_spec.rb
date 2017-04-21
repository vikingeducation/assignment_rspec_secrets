require 'rails_helper'
include ApplicationHelper

describe 'layouts/application.html.erb' do
  let(:user){ create(:user)}
  context 'logged out' do
    it 'shows login link' do
      render
      expect(rendered).to have_content('Login')
    end
  end
  context 'logged in' do
    before do
      view_sign_in(user)
    end
    it 'shows logout link' do
      render
      expect(rendered).to have_content('Logout')
    end
  end


end

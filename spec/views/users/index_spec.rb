require 'rails_helper'

describe 'users/index.html.erb' do
  let(:user){create(:user)}
  let(:users){[user, create(:user)]}
  let(:secrets){create_list(:secret, 2, :author => user)}
  let(:render_with_layout){render :template => 'users/index', :layout => 'layouts/application'}

  before do
    view.extend(ViewHelper)
    assign(:users, users)
  end

  context 'the user is logged in' do
    it 'displays a logout link' do
      login(user)
      render_with_layout
      expect(rendered).to have_content('Logout')
    end
  end

  context 'the user is logged out' do
    it 'displays a login link' do
      render_with_layout
      expect(rendered).to have_content('Login')
    end
  end
end
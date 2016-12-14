require 'rails_helper'

describe 'users/new.html.erb' do
  let(:user){create(:user)}
  let(:render_with_layout){render :template => 'users/new', :layout => 'layouts/application'}

  before do
    view.extend(ViewHelper)
    assign(:user, user)
  end

  it 'has an email label' do
    render_with_layout
    expect(rendered).to have_content('Email')
  end
end


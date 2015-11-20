require 'rails_helper'

describe 'secrets/show.html.erb' do
  let(:user){create(:user)}
  let(:secret){create(:secret, :author => user)}

  before do
    view.extend(ViewHelper)
    assign(:secret, secret)
  end

  context 'the user is logged in' do
    it 'shows the author of the secret' do
      login(user)
      render
      expect(rendered).to have_content(user.name)
    end
  end

  context 'the user is logged out' do
    it 'does not show the author of the secret' do
      render
      expect(rendered).to have_content(hidden_text)
    end
  end
end



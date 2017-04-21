require 'rails_helper'


describe 'secrets/show.html.erb' do
  let(:user){ create(:user)}
  let(:secret){ create(:secret)}
  before do
    assign(:secret, secret)
  end
  context 'logged out' do
    it 'does not show author for non-logged-in user' do
      render
      expect(rendered).to have_content('**hidden**')
    end
  end
  context 'logged in' do
    before do
      view_sign_in(user)
    end
    it 'shows author for logged in user' do
      render
      expect(rendered).to have_content(secret.author.name)
    end
  end
end

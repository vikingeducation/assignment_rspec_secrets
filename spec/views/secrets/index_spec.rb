require 'rails_helper'

describe 'secrets/index.html.erb' do
  context "Authenticated" do
    let(:secret){ create(:secret) }
    let(:user){ secret.author }
    let(:another) {create(:secret)}

    before do
      secret
      another
      session[:user_id] = user.id
    end

  end

  context "Unauthenticated" do

  end
end

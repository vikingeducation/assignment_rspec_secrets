require 'rails_helper'

describe SecretsController do

  let(:secret){ create(:secret, :with_attributes) }

  # before :each do
  #   session[:user_id] = user.id
  # end

  it "sets the right instance variable for secrets#show" do
    get :show, :id => secret.id
    expect(assigns(:secret)).to eq(secret)
  end

end
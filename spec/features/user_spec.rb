require 'rails_helper'

feature 'Users' do
  let!(:user) { create(:user) }
  let!(:secret) { user.secrets.create(attributes_for(:secret)) }

  it "signs up the user"

end
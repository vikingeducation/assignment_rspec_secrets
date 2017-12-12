require 'rails_helper'

RSpec.describe 'CreatingUsers', type: :request do
  describe 'POST #create' do
    context 'valid credentials' do
      it 'creates a new user' do
        expect{
          post users_path, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end
    end

    context 'invalid credentials' do
      it 'does not create a new user' do
        expect{
          post users_path, params: { user: attributes_for(:user, password: nil) }
        }.not_to change(User, :count)
      end
    end
  end
end

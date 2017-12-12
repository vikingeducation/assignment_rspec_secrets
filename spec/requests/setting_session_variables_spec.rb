require 'rails_helper'

RSpec.describe 'SettingSessionVariables', type: :request do
  describe 'POST #create' do
    let(:user) { create :user }

    context 'valid user sign in credentials' do
      it 'sets user_id to user id' do
        post session_path, params: { email: user.email, password: user.password }
        expect(session[:user_id]).not_to be_nil
      end
    end

    context 'invalid credentials' do
      before do
        post session_path, params: { email: user.email, password: 'blahditty' }
      end

      it 'does not set user_id' do
        expect(session[:user_id]).to be_nil
      end

      it 'sets the flash message' do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end

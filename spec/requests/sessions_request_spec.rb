require 'rails_helper'

describe 'SessionsRequests' do
  let(:user){ create(:user)}
  describe 'POST #create'
  it 'sets the right session variable' do
    post session_path, params: {email: user.email, password: user.password }
    expect(session[:user_id]).to eq(user.id)
  end
end

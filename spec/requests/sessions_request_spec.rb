require 'rails_helper'

describe 'SessionsRequests' do

  let(:user){ create(:user) }

  describe 'GET #new' do

    it 'is successful' do
      get new_session_path
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid inputs' do
      it 'persists user in sessions hash' do
        post session_path, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to eq(user.id)
      end
      it 'redirects you to root_path' do
        post session_path, params: { email: user.email, password: user.password }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid inputs' do

      let(:invalid_password){ "invalid password" }

      it 'does not persist user in session hash'  do
        post session_path, params: { email: user.email, password: invalid_password }
        expect(session[:user_id]).to_not eq(user.id)
      end
      it 're-renders new form' do
        post session_path, params: { email: user.email, password: invalid_password }
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'DELETE #destroy' do
    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end
    it 'logs user out (removes from sessions hash)' do
      delete session_path
      expect(session[:user_id]).to_not eq(user.id)
    end
    it 'redirects to root path' do
      delete session_path
      expect(response).to redirect_to root_path
    end 
  end


end

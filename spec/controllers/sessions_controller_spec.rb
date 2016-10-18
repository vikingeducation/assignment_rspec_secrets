require 'rails_helper'

describe SessionsController do
  let(:user){create(:user)}

  before do
    user
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------
  describe 'POST #create' do
    context 'the credentials were valid' do
      before do
        process :create, params: {
          :email => user.email,
          :password => user.password
        }
      end

      it 'results in the user being signed into the session' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'the credentials were invalid' do
      before do
        process :create, params: {
          :email => 'foo',
          :password => 'bar'
        }
      end

      it 'does not sign in the user' do
        expect(session[:user_id]).to be_nil
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end
  end

  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------
  describe 'DELETE #destroy' do
    before do
      process :create, params: {
        :email => user.email,
        :password => user.password
      }
      process :destroy
    end

    it 'removes a signed in user from the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to root_path
    end
  end
end






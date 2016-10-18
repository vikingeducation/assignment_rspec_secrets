require 'rails_helper'

describe ApplicationController do
  let(:user){create(:user)}

  before do
    user
    controller.send(:sign_in, user)
  end

  # ----------------------------------------
  # Create anonymous controller
  # ----------------------------------------
  controller do
    before_action :require_login, :only => [:index]
    before_action :require_current_user, :only => [:show]

    def index
      render :plain => 'Index'
    end

    def show
      render :plain => 'Show'
    end
  end

  # ----------------------------------------
  # #sign_in
  # ----------------------------------------
  describe '#sign_in' do
    it 'sets the user id in the session hash' do
      expect(session[:user_id]).to eq(user.id)
    end

    it 'sets the current user to the passed user' do
      expect(controller.send(:current_user)).to eq(user)
    end
  end

  # ----------------------------------------
  # #sign_out
  # ----------------------------------------
  describe '#sign_out' do
    before do
      controller.send(:sign_out)
    end

    it 'removes the user id from the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'sets the current user to nil' do
      expect(controller.send(:current_user)).to be_nil
    end
  end

  # ----------------------------------------
  # #current_user
  # ----------------------------------------
  describe '#current_user' do
    it 'returns the current user in the session if one exists' do
      expect(controller.send(:current_user)).to eq(user)
    end

    it 'returns nil if there is no user id in the session' do
      session.delete(:user_id)
      expect(controller.send(:current_user)).to be_nil
    end

    it 'returns nil if the user does not exist in the database' do
      User.find(user.id).destroy!
      expect(controller.send(:current_user)).to be_nil
    end
  end

  # ----------------------------------------
  # #signed_in_user?
  # ----------------------------------------
  describe '#signed_in_user?' do
    it 'returns true if the current user is signed in' do
      expect(controller.send(:signed_in_user?)).to eq(true)
    end

    it 'returns false if there is no user signed in' do
      controller.send(:sign_out)
      expect(controller.send(:signed_in_user?)).to eq(false)
    end
  end

  # ----------------------------------------
  # #require_login
  # ----------------------------------------
  describe '#require_login' do
    it 'does nothing if the user is signed in' do
      process :index
      expect(response).to_not redirect_to %r(.*)
    end

    it 'redirects if the user is not signed in' do
      controller.send(:sign_out)
      process :index
      expect(response).to redirect_to new_session_path
    end
  end

  # ----------------------------------------
  # #require_current_user
  # ----------------------------------------
  describe '#require_current_user' do
    it 'does nothing if there is a current user' do
      process :show, params: { :id => user.id }
      expect(response).to_not redirect_to %r(.*)
    end

    it 'redirects if the current user is not authorized to perform the action' do
      process :show, params: { :id => '1234' }
      expect(response).to redirect_to root_path
    end
  end
end







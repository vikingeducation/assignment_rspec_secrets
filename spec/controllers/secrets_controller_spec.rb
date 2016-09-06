require 'rails_helper'

describe SecretsController do
  describe '#show' do
    let(:secret){ create(:secret) }

    it "sets the right instance variable" do
      get :show, :id => secret.id
      expect(assigns(:secret)).to match secret
    end
  end

  describe 'edit permission' do
    let(:secret){ create(:secret) }
    let(:updated_title){ "updated_title" }
    before :each do
      session[:user_id] = secret.author.id
    end
    it 'can be edit by its author #update' do
      put :update, :id => secret.id,
                   :secret => attributes_for(:secret, :title => updated_title)
      secret.reload
      expect(secret.title).to eq(updated_title)
    end

    it 'can be deleted by its author #destroy' do
      expect{
        delete :destroy, :id => secret.id
      }.to change(Secret, :count).by(-1)
    end
  end

  describe 'valid user login' do
    let(:user){ create(:user) }
    before :each do
      session[:user_id] = user.id
    end
    it 'can create new secret' do
      expect{
        post :create, :secret => attributes_for(:secret)
      }.to change(Secret, :count).by(1)
    end

    it 'get a new flash after creating new secret' do
      post :create, :secret => attributes_for(:secret)
      expect(flash[:notice]).not_to be_nil
    end
  end

  describe 'unpermitted edit is not allowed' do
    let!(:secret){ create(:secret) }
    let(:another_user){ create(:user) }
    let(:updated_title){ "updated_title" }
    before :each do
      session[:user_id] = another_user.id
    end
    it 'can not be edit by another user' do
      expect{put :update, :id => secret.id,
                   :secret => attributes_for(:secret, :title => updated_title)
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'can not be deleted by another user' do
      expect{
        delete :destroy, :id => secret.id
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end


end

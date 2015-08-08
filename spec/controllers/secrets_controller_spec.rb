require 'rails_helper'

describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user) }

  context 'RESTful secrets actions' do

    before do
      session[:user_id] = user.id
    end

    describe "GET #show" do

      it "sets the right instance variable" do
        get :show, :id => secret.id
        expect(assigns(:secret)).to eq(secret)
      end

      it "should not set a wrong instance variable" do
        secret2 = create(:secret)
        get :show, :id => secret2.id
        expect(assigns(:secret)).to_not eq(secret)
      end

    end

    describe 'GET #edit' do

      it 'renders the right page' do
        get :edit, :id => secret.id
        expect(response).to render_template(:edit)
      end

      it 'does not render for a user not owning the secret' do
        secret2 = create(:secret)
        expect{get :edit, id: secret2.id}.to raise_error(ActiveRecord::RecordNotFound)
      end

    end

    describe 'PUT #update' do

      it 'can be changed by owner' do
        put :update,  id: secret.id,
                      secret: attributes_for(
                              :secret, 
                              title: "new_title")
        secret.reload
        expect(secret.title).to eq("new_title")
      end

      it 'cannot be changed by a person other than owner' do
        # # user2 = create(:user)
        # secret2 = create(:secret)
        # # binding.pry
        # get :edit, id: secret.id
        # # post :update,  id: secret2.id,
        # #               secret: attributes_for(
        # #                       :secret, 
        # #                       title: "new_title")
        # # secret2.reload
        # expect(response).to redirect_to(new_session_path)
      end

    end

  end

end
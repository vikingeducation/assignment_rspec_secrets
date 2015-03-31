require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    it 'renders the page normally' do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'POST #create' do
    it 'proper submission creates a new user' do
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by 1
    end
    it 'improper submission re-renders the page' do
      post :create, user: {name: "Foo", email: "foo_you@bar.com"}
      expect(response).to render_template :new
    end
  end
end

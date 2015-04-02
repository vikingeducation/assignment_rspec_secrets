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
  describe 'GET #edit' do
    it 'sets the right instance variables'
    it 'user is able to edit their own account'
    it 'user is not able to edit another user\'s account'
  end
  describe 'DELETE #destroy' do
    it 'user is able to delete their own account'
    it 'user is not able to delete another user\'s account'
  end
end

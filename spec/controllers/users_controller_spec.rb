require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }
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
  describe 'user access' do
    let(:other_user){ create(:user, email: "other@user.com") }
    before do
      session[:user_id] = user.id
    end
    describe 'GET #edit' do
      it 'sets the right instance variables' do
	get :edit, id: user.id
	expect(assigns(:user)).to match user
      end
      it 'user is able to edit their own account' do
	get :edit, id: user.id
	expect(response).to render_template :edit
      end
      it 'user is not able to edit another user\'s account' do
	get :edit, id: other_user.id
	expect(response).to redirect_to root_path
      end
    end
    describe 'DELETE #destroy' do
      it 'user is able to delete their own account' do
	expect{
	  delete :destroy, id: user.id
	}.to change(User, :count).by -1
      end
      it 'user is not able to delete another user\'s account' do
	delete :destroy, id: other_user.id
	expect(response).to redirect_to root_path
      end
    end
  end
end

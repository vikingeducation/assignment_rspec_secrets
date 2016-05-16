require 'rails_helper'

describe SessionsController do

  let( :user ){ create(:user) }

  describe 'post #create' do
    it "sets @user" do
      post :create, :email => user.email

      expect(assigns(:user)).to eq(user)
    end

    it "renders :new template if sign in is not successful" do
      post :create, :email => user.email

      expect(response).to render_template :new
    end

    it "redirect to root_url if sign in is successful" do
      post :create, :email => user.email, :password => user.password

      expect(response).to redirect_to(root_url)
    end
  end

  describe 'delete #destroy' do

    # You gotta be logged in to be able to log out!
    before do
      session[:user_id] = user.id
    end

    it "redirects to root_url" do
      delete :destroy

      expect(response).to redirect_to(root_url)
    end
  end
end
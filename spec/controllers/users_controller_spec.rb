require 'rails_helper'

describe UsersController do

  let(:user){ create(:user, :with_attributes) }
  let(:secret){ create(:secret, :with_attributes, author_id: user.id)}

  it "user#create will create a new User" do
    expect{post :create, user: attributes_for(:user, :with_attributes)}.to change(User, :count).by(1)
  end

  it "user#create with no attributes will not create a new User" do
    expect{post :create, user: attributes_for(:user, :without_attributes)}.to change(User, :count).by(0)
  end

  context "for signed in user" do

    before :each do
      session[:user_id] = user.id
    end

    it "authorized user has access to user#edit for own edit" do
      get :edit, id: user.id
      expect(response).to render_template :edit
    end

  end


end
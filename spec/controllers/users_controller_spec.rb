require 'rails_helper'


describe UsersController do

  let(:user){create(:user)}

  it 'should create a new User with proper parameters' do

    expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)

  end

  it 'should not create a new User without all parameters' do

    expect{post :create, user: attributes_for(:user, email: nil)}.to change(User, :count).by(0)
  end

  it 'should set the instance variable correctly for a user' do
    session[:user_id] = user.id
    get :edit, id: user.id

    expect(assigns(:user)).to eq(user)
  end

  it 'should not set the instance variable correctly for mismatched user' do
    other_user = create(:user)
    session[:user_id] = other_user.id
    get :edit, id: user.id

    expect(response).to redirect_to root_url
  end

  it 'should raise error if user does not exist' do
    session[:user_id] = user.id
    expect{get :edit, id: user.id + 1}.to raise_error(ActiveRecord::RecordNotFound)
  end


end

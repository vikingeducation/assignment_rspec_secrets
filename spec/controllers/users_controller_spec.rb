require 'rails_helper'


describe UsersController do

  let(:user){create(:user)}

  it 'should create a new User with proper parameters' do

    expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)

  end

  it 'should not create a new User without all parameters' do

    expect{post :create, user: attributes_for(:user, email: nil)}.to change(User, :count).by(0)
  end


end
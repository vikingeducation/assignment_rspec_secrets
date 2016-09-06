require 'rails_helper'

describe UsersController do
  describe '#create' do
    it "create a new user with valid parameters" do
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it 'can not create user with invalid parameters' do
      expect{
        post :create, user: attributes_for(:user, :name => "a")
      }.to change(User, :count).by(0)
    end
  end

  describe "user access" do
    let(:user){ create(:user) }
    let(:another_user){ create(:user) }
    let(:updated_name){ "update_fucker" }
    before :each do
      session[:user_id] = user.id
    end

    describe 'PATCH #update' do
      before { user }
      context "with valid attributes" do
        it "actually updates the user" do
          put :update, :id => user.id,
                       :user => attributes_for(:user, :name => updated_name)
          user.reload
          expect(user.name).to eq(updated_name)
        end
      end

      context "failed to edit another user" do
        before { another_user }
        it "can't edit another user" do
          puts :update, :id => another_user.id,
                        :user => attributes_for(:user, :name => updated_name)
          another_user.reload
          expect(another_user.name).not_to eq(updated_name)
        end
      end
    end

    describe 'DELETE #destroy' do
      before { user }
      before { another_user }
      it "can destroy its user account" do
        expect{
          delete :destroy, :id => user.id
        }.to change(User, :count).by(-1)
      end

      it "can not delete another_user" do
        expect{
          delete :destroy, :id => another_user.id
        }.to change(User, :count).by(0)
      end
    end
  end

  # describe '#edit' do
  #   let(:user){ create(:user) }
  #   it 'assign the @user' do
  #     get :edit, :id => user.id
  #     expect(assigns(:user)).to match user
  #   end
  # end


end

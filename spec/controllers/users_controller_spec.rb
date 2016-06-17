require "rails_helper"

describe UsersController do
  let(:user){ create(:user) }

  describe 'POST #create' do

    it 'create a new user as expected' do
      expect{ 
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it "doesn't create a user if an argument is missing" do
      expect{
        post :create, user: attributes_for( :user, 
                                            email: "" )
      }.to change(User, :count).by(0)
    end
  end

  describe "GET #edit" do

    context 'Signed in' do
      before do
        session_sign_in(user)
      end

      it "should allow the user to edit his profile" do
        get :edit, id: user.id

        expect(response).to render_template :edit
      end

      it "should not allow a user to edit another user" do
        another_user = create(:user)
        get :edit, id: another_user.id

        expect(response).to redirect_to root_path
      end
    end

    context 'Not signed in' do

      it "should not allow a visitor to edit a user's profile" do
        get :edit, id: user.id

        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'DELETE #destroy' do

    context "Signed in user" do
      before do
        session_sign_in(user)
      end

      it 'should be able to destroy their account' do
        expect{
          delete :destroy, id: user.id
        }.to change(User, :count).by(-1)
      end

      it "should not be able to destroy another user account" do
        another_user = create(:user)

        expect{
          delete :destroy, id: another_user.id
        }.to change(User, :count).by(0)
      end
    end


    context 'Visitor' do

      it "should not be able to delete a user account" do
        user
        puts User.all.count
        expect{
          delete :destroy, id: user.id
        }.to change(User, :count).by(0)
        puts User.all.count
      end

      it 'should redirect the visitor to sign in' do
        delete :destroy, id: user.id
        expect(response).to redirect_to new_session_path
      end
    end
  end
end
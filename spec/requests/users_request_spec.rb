require 'rails_helper'

describe 'UserRequests' do

  let(:user){create(:user)}
  let(:another_user){create(:user)}
  let(:new_user_name){"My_new_name"}

  describe "POST #create" do

      let(:another_user_name){"s"}

      it "proper submission creates a new user" do
        expect{post users_path, params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
      end

      it "improper submission doesn't create a new user" do
         expect{post users_path, params: { user: attributes_for(:user, :name => another_user_name) } }.to change(User, :count).by(0)
       end

   end

   describe "PATCH #edit" do

     before do
       user
       another_user
       login_as(user)
     end

     it "authorized users can edit their profile" do
       patch user_path(user), params: {:user => attributes_for(:user, :name => new_user_name) }
       user.reload
       expect(user.name).to eq(new_user_name)
     end

     it "unauthorized users cannot edit someone else's profile" do

     end
   end


   describe "DELETE #destroy" do

     before do
       user
       another_user
       login_as(user)
     end

     context "authorized users can delete their profile" do
       it "destroys the user" do
         expect{ delete user_path(user)}.to change(User, :count).by(-1)
       end

       it "redirects to the root" do
        delete user_path(user)
        expect(response).to redirect_to users_url
      end
    end

     it "unauthorized users cannot delete someone else's profile" do

     end
   end

end

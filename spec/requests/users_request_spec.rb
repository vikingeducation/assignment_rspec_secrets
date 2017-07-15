require 'rails_helper'

describe 'UserRequests' do

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
     let(:user){create(:user)}
     let(:another_user){create(:user)}

     before do
       user
       another_user
       login_as(user)
     end

     it "authorized users can edit their profile" do

     end

     it "unauthorized users cannot edit someone else's profile" do

     end
   end


   describe "DELETE #destroy" do
     it "authorized users can delete their profile" do

     end

     it "unauthorized users cannot delete someone else's profile" do

     end
   end

end

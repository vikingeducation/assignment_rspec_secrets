
require 'rails_helper'

describe User do

  describe 'valid_default_user' do 
 
   let(:user){ build(:user) }

    it "is valid with default attributes" do
      expect(user).to be_valid
    end
  end

  describe 'validates_email' do
     let(:user){ create(:user) }

     it "does not allow duplicate emails" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end

      it "does not allow blank email" do
        new_user = build(:user, :email => "")
        expect(new_user).not_to be_valid
      end
  end

  describe 'validates_name' do

   it "does not allow a name length of less than 3" do
        new_user = build(:user, :name => 'fo')
        expect(new_user).not_to be_valid
      end

    it "does not allow a name length of more than 20" do
        new_user = build(:user, :name => 'foooooooooooooooooooo')
        expect(new_user).not_to be_valid
    end  

  end

  describe 'validates_password' do

    it "does not allow a password length of less than 6" do
        new_user = build(:user, :password => '12345')
        expect(new_user).not_to be_valid
    end

    it "does not allow a password length of more than 16" do
        new_user = build(:user, :password => '12345678901234567')
        expect(new_user).not_to be_valid
    end  

    it "does allow to update user without password" do
        new_user = create(:user)
        expect {
          new_user.update!(name: "xyzabc", email: "thisuser@aol.com")
        }.to_not raise_error
    end  
  
  end

  describe 'checks secrets association' do
    it "responds to the secrets association" do
      new_user = build(:user)
      expect(new_user).to respond_to(:secrets)
    end
  end

  describe 'checks that multiple secrets can be created for user' do
    let(:user){ build(:user) }
    it "gives 5 secrets when 5 are assigned to author" do
      secrets = create_list(:secret, 5, author: user)
      expect(user.secrets.count).to eq(5)
    end
  end  


  describe 'checks that multiple users can be created' do
    it "gives 10 users" do
      users = create_list(:user, 10)
      expect(users.count).to eq(10)
    end
  end  

end
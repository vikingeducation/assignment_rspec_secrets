require 'rails_helper'

describe User do

	# Create a user from our user factory
  let(:user){ build(:user) }

  context "User validations" do


    it "is valid with default attributes" do
      expect(user).to be_valid
    end

   
    it "saves with default attributes" do
      expect{ user.save! }.to_not raise_error
    end


    context "User secrets association" do
      # responds to secrets association
      # QUESTION: Is this an alright test? We're not testing if
      # the association we're only seeing if we set up our 
      # factories right, correct? 
      it "has a valid secrets association with one secret" do
        user = create(:user_with_secret)
        expect(user.secrets.count).to eq(1)
      end

      it "has a valid secrets association with multiple secrets" do
        user = create(:user_with_secret)
        3.times { create(:secret, :author_id => user.id) }          
        expect(user.secrets.count).to eq(4)
        
      end

    end
    

    context "User email validations" do
      

      it "doesn't allow identical email addresses" do
        user.save!
        new_user = build(:user, :email => user.email)
        expect(new_user.valid?).to eq(false)
      end


      # email must be present
      it "validates user email on presence" do
        user = build(:user, :email => nil)
        expect(user.valid?).to be(false)
      end

    end
    

    context "User name validations" do
      

      # name must be present
      it "validates user name on presence" do
        user = build(:user, :name => nil)
        expect(user.valid?).to be(false)
      end


      # name length 3..20
      it "invalidates names with less than 3 characters" do
        user = build(:user, :name => "aa")
        expect(user.valid?).to be(false)
      end


      it "invalidates names with more than 20 characters" do
        user = build(:user, :name => "a"*21)
        expect(user.valid?).to be(false)
      end

    end


    context "User password validations" do
      

      # password length in 6..16
      it "invalidates passwords under 6 characters" do
        user = build(:user, :password => "pass", :password_confirmation => "pass")
        expect(user.valid?).to be(false)
      end    


      it "invalidates passwords under 6 characters" do
        user = build(:user, :password => "pass"*5, :password_confirmation => "pass"*5)
        expect(user.valid?).to be(false)
      end   
    end


  end


end
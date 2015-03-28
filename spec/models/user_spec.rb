require 'rails_helper'

describe User do 

  let(:user){ build(:user) }

  it "is valid out of the gate with default settings" do
    expect(user).to be_valid
  end
  it "saves without flippin out" do
    expect{ user.save! }.to_not raise_error
  end

  it "will respond to secrets association" do
    expect(user).to respond_to(:secrets)
  end

  describe "attributes" do

    context "when names or passwords are wrong length" do 

      it "doesn't allow short names" do 
        new_user = build(:user, :name => "wa")
        expect(new_user).not_to be_valid
      end

      it "doesn't allow long name" do 
        new_user = build(:user, :name => "waaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        expect(new_user).not_to be_valid
      end

      it "doesn't allow short passwords" do 
        new_user = build(:user, :password => "whale")
        expect(new_user).not_to be_valid
      end
      it "doesn't allow long passwords" do 
        new_user = build(:user, :password => "whalalalalaldsafdsafdsdfadsfa")
        expect(new_user).not_to be_valid
      end
    end

    context "when names and passwords are good" do

      it "likes correct length passwords" do
        new_user = build(:user, :password => "ilovelamp")
        expect(new_user).to be_valid
      end
      it "likes correct length names" do
        new_user = build(:user, :name => "thisisschwad")
        expect(new_user).to be_valid
      end
    end

    context "bad" do
      it "is invalid without an email address" do
        new_user = build(:user, :email => nil)
        expect(new_user.valid?).to eq(false)
      end
      it "is invalid without a name" do
        new_user = build(:user, :name => nil)
        expect(new_user.valid?).to eq(false)
      end
    end
  end
end

describe Secret do
  let(:secret){ build(:secret)}

  it "responds to user" do
    expect(secret).to respond_to(:author)
  end

  describe "attributes" do 
    context "various lengths of attributes" do 
      it "will reject a short title" do 
        new_secret = build(:secret, :title => "hi")
        expect(new_secret).not_to be_valid
      end

      it "will reject a long title" do 
        new_secret = build(:secret, :title => "aaaaaaaaaaaahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
        expect(new_secret).not_to be_valid
      end

      it "does not mind a regular length title" do
        new_secret = build(:secret, :title => "sweet man! :)")
        expect(new_secret).to be_valid
      end
    end
  end

  describe "methods" do 
    it "does not return more than five secrets" do
      expect(Secret.last_five.length).to be < 6
    end
  end
end
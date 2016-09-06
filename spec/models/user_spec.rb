require 'rails_helper'

describe User do
  describe "user validations" do
    let(:user){ build(:user) }
    it "is valid with default parameters" do
      expect(user).to be_valid
    end
    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end
    it "without a name is invalid" do
      user = build(:user, :name => nil)
      expect(user).not_to be_valid
    end
    it "without a email is invalid" do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end
    it "with name length 2 is invalid" do
      user = build(:user, :name => "12")
      expect(user).not_to be_valid
    end
    it "with name length 21 is invalid" do
      user = build(:user, :name => 'a' * 21)
      expect(user).not_to be_valid
    end
    it "with name length 3 is valid" do
      user = build(:user, :name => '123')
      expect(user).to be_valid
    end
    it "with name length 20 is valid" do
      user = build(:user, :name => 'a' * 20)
      expect(user).to be_valid
    end
    it "with no email is invalid" do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end
    it "with duplicate email address is invalid" do
      user.save!
      dup_user = build(:user, :email => user.email)
      expect(dup_user).not_to be_valid
    end
    it "with password length 5 is invalid" do
      user = build(:user, :password => 'a' * 5)
      expect(user).not_to be_valid
    end
    it "with password length 6 is valid" do
      user = build(:user, :password => 'a' * 6)
      expect(user).to be_valid
    end
    it "with password length 17 is invalid" do
      user = build(:user, :password => 'a' * 17)
      expect(user).not_to be_valid
    end
    it "with password length 16 is valid" do
      user = build(:user, :password => 'a' * 16)
      expect(user).to be_valid
    end
  end

end

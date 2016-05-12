require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  describe "associations" do
    it "responds to the secrets association" do
      expect(user).to respond_to(:secrets)
    end

    it "does not respond to the posts association" do
      expect(user).not_to respond_to(:posts)
    end
  end

  describe "attributes" do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    # This test is redundant because the above test already shows that the user is valid.
    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end

    it "is not valid without a name" do
      new_user = build(:user, :name => "")
      expect(new_user).not_to be_valid
    end

    it "is not valid without a name" do
      new_user = build(:user, :email => "")
      expect(new_user).not_to be_valid
    end

    context "name lengths" do
      it "is not valid when the name is 2 characters" do
        new_user = build(:user, :name => "Ae")
        expect(new_user).not_to be_valid
      end

      it "is valid when the name is 3 characters" do
        new_user = build(:user, :name => "Sam")
        expect(new_user).to be_valid
      end

      it "is valid when the name is 20 characters" do
        new_user = build(:user, :name => "12345678901234567890")
        expect(new_user).to be_valid
      end

      it "is not valid when the name is 22 characters" do
        new_user = build(:user, :name => "1234567890 1234567890")
        expect(new_user).not_to be_valid
      end
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end

    context "password lengths" do
      it "is not valid when password is 5 characters" do
        new_user = build(:user, :password => "12345")
        expect(new_user).not_to be_valid
      end

      it "is valid when password is 6 characters" do
        new_user = build(:user, :password => "123456")
        expect(new_user).to be_valid
      end

      it "is valid when password is 16 characters" do
        new_user = build(:user, :password => "1234567890123456")
        expect(new_user).to be_valid
      end

      it "is valid when password is 17 characters" do
        new_user = build(:user, :password => "12345678901234567")
        expect(new_user).not_to be_valid
      end
    end

  end
end
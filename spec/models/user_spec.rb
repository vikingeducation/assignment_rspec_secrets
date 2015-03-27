require 'rails_helper'
describe User do
  let(:user){ build(:user)}

  describe "attributes" do
    it "is valid with a name, emaiol, and password" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{(user.save!)}.to_not raise_error
    end

    it "is invalid without a name" do
      expect{create(:user, :name => nil)}.to raise_error
    end

    it "is invalid withut an email" do
      expect{create(:user, name: nil)}.to raise_error
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

    it "is invalid with a short name" do
      expect(build(:user, name: "yo")).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(build(:user, name: "yoooooooooooooooooooooooooooooooooooooooooooooooo")).not_to be_valid
    end

    it "is valid with a 3 character long name" do
      expect(build(:user, name: "hey")).to be_valid
    end

    it "is valid with a 20 character long name" do
      expect(build(:user, name: "12345678901234567890")).to be_valid
    end

    it "is invalid without a password" do
      expect(build(:user, password: nil)).to_not be_valid
    end

    it "is invalid with a password less than 6 characters long" do
      expect(build(:user, password: "12345")).to_not be_valid
    end

    it "is invalid with a password more than 20 characters long" do
      expect(build(:user, password: "123456789012345678901123")).to_not be_valid
    end

    it "is valid with a password of 6 characters" do
      expect(build(:user, password: "123456")).to be_valid
    end

    it "is valid with a password of 20 characters" do
      expect(build(:user, password: "1234567890123456")).to be_valid
    end
  end

  describe "associations" do
    it "responds to posts" do
      expect(user).to respond_to(:secrets)
    end
  end
end
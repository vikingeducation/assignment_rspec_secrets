require 'rails_helper'


describe User do

  let(:user){ build(:user) }

  describe "attributes" do

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end

    it "without a name is invalid" do
      new_user = build(:user, name: nil)
      expect(new_user).not_to be_valid
    end

    it "name is too short" do
      new_user = build(:user, name: "hi")
      expect(new_user).not_to be_valid
    end

    it "name is too long" do
      new_user = build(:user, name: "a" * 21)
      expect(new_user).not_to be_valid
    end

    it "without an email address is invalid" do
      new_user = build(:user, email: nil)
      expect(new_user).not_to be_valid
    end

    context "when saving multiple users" do

      before do
        user.save!
      end

      it "doesn't allow identical email addresses" do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end

    end

    it "without password is invalid" do
      new_user = build(:user, password: nil)
      expect(new_user).not_to be_valid
    end

    it "password is too short" do
      new_user = build(:user, password: "1234")
      expect(new_user).not_to be_valid
    end

    it "password is too long" do
      new_user = build(:user, password: "1" * 17)
      expect(new_user).not_to be_valid
    end

    it "password not required on update" do
      user.save
      user.update!(name: "Kitty")
      expect(user.name).to eq("Kitty")
    end

  end
end

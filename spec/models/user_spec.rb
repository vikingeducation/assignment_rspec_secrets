require 'rails_helper'

describe User do
  let(:user){ build(:user) }
  describe "attribute" do
    it "all pass when a name, email, and password within constraints" do
      expect(user).to be_valid
    end

    describe "name" do
      it "is invalid when blank" do
        new_user = build(:user, name: nil)
        expect(new_user).to_not be_valid
      end
      it "is invalid if <4 or >20 characters long" do
        new_user_short = build(:user, name: "No")
        new_user_long = build(:user, name: "F" * 21)
        expect(new_user_short).to_not be_valid
        expect(new_user_long).to_not be_valid
      end
      it "is valid if exactly 4 or 20 characters long" do
        new_user_exact_short = build(:user, name: "ayyy")
        new_user_exact_long = build(:user, name: "F" * 20)
        expect(new_user_exact_short).to be_valid
        expect(new_user_exact_long).to be_valid
      end
    end

    describe "email" do
      it "is invalid when blank" do
        new_user = build(:user, email: nil)
        expect(new_user).to_not be_valid
      end
      context "when saving multiple users" do
        before do
          user.save!
        end
        it "is invalid without a unique email" do
          new_user = build(:user, email: user.email)
          expect(new_user).to_not be_valid
        end
      end
    end

    describe "password" do
      it "is invalid when blank" do
        new_user = build(:user, password: nil)
        expect(new_user).to_not be_valid
      end
      it "is invalid if <6 or >16 characters long" do
        new_user_short = build(:user, password: "No")
        new_user_long = build(:user, password: "F" * 17)
        expect(new_user_short).to_not be_valid
        expect(new_user_long).to_not be_valid
      end
      it "is valid if exactly 6 or 16 characters long" do
        new_user_short = build(:user, password: "ayyyyy")
        new_user_long = build(:user, password: "F" * 16)
        expect(new_user_short).to be_valid
        expect(new_user_long).to be_valid
      end
    end

  end

  describe "associations" do
    it "responds to the secrets association" do
      expect(user).to respond_to(:secrets)
    end
  end

end

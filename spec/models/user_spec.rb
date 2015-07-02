require 'rails_helper'

describe User do
  let(:user){ build(:user) }
  describe "attributes" do
    it "is valid with a name, email, and password within constraints" do
      expect(user).to be_valid
    end
    it "is invalid without a name" do
      new_user = build(:user, name: nil)
      expect(new_user).to_not be_valid
    end
    it "is invalid with a name shorter than 3 characters long" do
      new_user = build(:user, name: "No")
      expect(new_user).to_not be_valid
    end
    it "is invalid with a name greater than 20 characters long" do
      new_user = build(:user, name: "Faaaaaaaaaaaaaaaaaaail")
      expect(new_user).to_not be_valid
    end
    it "is invalid without an email" do
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
end

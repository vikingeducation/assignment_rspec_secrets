# spec/models/user_spec.rb

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  context "creating a new User:" do
    it "is successful with valid attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect { user.save! }.not_to raise_error
    end
  end

  context "when saving multiple Users:" do
    before { user.save! }
    it "does not allow identical email addresses" do
      new_user = build(:user, email: user.email)
      expect(new_user.valid?).to be false
    end
  end

  context "validations:" do
    it "ensures the length of a User's name is >= 3 characters" do
      user.name = "aa"
      expect(user).not_to be_valid
    end

    it "ensures the length of a User's name is <= 20 characters" do
      user.name = "a" * 21
      expect(user).not_to be_valid
    end

    it "ensures the length of a User's password is >= 6 characters" do
      user.password = "a" * 5
      user.password_confirmation = "a" * 5
      expect(user).not_to be_valid
    end

    it "ensures the length of a User's password is <= 16 characters" do
      user.password = "a" * 17
      user.password_confirmation = "a" * 17
      expect(user).not_to be_valid
    end
  end

  context "associations:" do
    it "responds to the secrets association" do
      expect(user).to respond_to(:secrets)
    end
  end
end

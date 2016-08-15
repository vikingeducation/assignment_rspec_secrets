require 'rails_helper'

describe User do

  describe "Validations" do
    let(:user) { build(:user) }

    it "validates presence of name" do
      is_expected.to validate_presence_of(:name)
    end

    it "has a secure password" do
      is_expected.to have_secure_password
    end

    it "ensures length of name" do
      is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20)
    end

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "is invalid without name" do
      no_name = build(:user, name: "")
      expect(no_name).to_not be_valid
    end

    it "is invalid with short name" do
      no_name = build(:user, name: "as")
      expect(no_name).to_not be_valid
    end

    it "is invalid with duplicate email" do
      user.save
      duplicate_email = build(:user, email: user.email)
      expect(duplicate_email).to_not be_valid
    end

    it "is invalid with short password" do
      short_pw = build(:user, password: "short")
      expect(short_pw).to_not be_valid
    end

  end

  describe "Associations" do
    let(:user) { build(:user) }
    let(:secret) {build(:secret) }

    it "has associated secrets" do
      expect(user).to respond_to(:secrets)
    end

    it "has many secrets" do
      expect(user).to have_many(:secrets)
      #or
      #is_expected.to have_many (:secrets)
    end

  end


end

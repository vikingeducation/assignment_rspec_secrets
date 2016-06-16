require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  context "validation" do

    it "should be valid with a name, email, and password" do
      expect(user).to be_valid
    end

    it "should not be valid if a name is missing" do
      user.name = ""
      expect(user).not_to be_valid
    end

    it "should not be valid if a email is missing" do
      user.email = ""
      expect(user).not_to be_valid
    end

    it "should be invalid is password is too short, or too long" do
      user.password = "pass"
      expect(user).not_to be_valid

      user.password = "itsaverylongpasswordsoitshouldntwork"
      expect(user).not_to be_valid
    end

    it "should not be valid is the name is too short, or too long" do
      user.name = "a"
      expect(user).not_to be_valid

      user.name = "itsaverylongnamesoitshouldnotbevalidandshouldntwork"
      expect(user).not_to be_valid
    end

    it "should be invalid if the email exist already" do
      user.save!
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end
  end

  context "association" do
    it "should respond to the secrets association" do
      expect(user).to respond_to(:secrets)
    end
  end

end
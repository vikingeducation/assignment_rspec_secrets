require 'rails_helper'

describe User do
  let(:user){ build(:user) }
  let(:other_user){ build(:user, email: user.email)}

  context "basic validations" do
    it "returns a user's name as a string" do
      user.save
      expect(user.name).to be_a(String)
    end
    it "without a name is invalid" do
      user.name = nil
      expect(user).to be_invalid
    end
    it "with a name and email is valid" do
      expect(user).to be_valid
    end
    it "without an email address is invalid" do
      user.email = nil
      expect(user).to be_invalid
    end
  end

  context 'specific validations' do
    it "with a duplicate email address is invalid" do
      user.save
      expect(other_user).to be_invalid
    end
    it 'invalid if password length less than 6' do
      user.password = 'five'
      expect(user).to be_invalid
    end
    it 'invalid if password length more than 16' do
      user.password = 'someridiculouslylongpassword'
      expect(user).to be_invalid
    end
    it 'valid if password length if between 6 and 16 chars' do
      user.password = "therightnumber"
      expect(user).to be_valid
    end
    it "is invalid if name more than 20 chars long" do
      user.name = 'someridiculouslylongnamethaticanteventhinkup'
      expect(user).to be_invalid
    end
    it 'is invalid if name less than 3 chars long' do
      user.name = 'hi'
      expect(user).to be_invalid
    end
    it 'valid if name between 3 and 20 chars' do
      user.name = 'validname'
      expect(user).to be_valid
    end
  end

  context 'associations' do
    it 'responds to secrets' do
      user.save
      expect(user).to respond_to(:secrets)
    end
  end
end

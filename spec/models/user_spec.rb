require 'rails_helper'

describe User do

  describe "Validations" do
    let(:user){ build(:user) }

    it "is valid" do
      expect(user).to be_valid
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

    it 'with a valid with name, email, and password is valid' do
      expect(user).to be_valid
    end

    it 'without a name is invalid' do
      new_user = build(:user, name: nil)
      expect(new_user).not_to be_valid
    end

    it 'without an email is invalid' do
      new_user = build(:user, email: nil)
      expect(new_user).not_to be_valid
    end

    it 'without a password is invalid' do
      new_user = build(:user, password: nil, password_confirmation: nil)
      expect(new_user).not_to be_valid
    end
  end

end
require 'rails_helper'
require 'pry'

describe User do
  let(:user){ create(:user)}

  describe "is complete" do
    it "when name, email and password are present." do
      expect(user).to be_valid
    end
  end

  describe "name" do
    it "must be present." do
      user_without_name = build(:user, name: nil)
      expect(user_without_name).not_to be_valid
    end
    it "is not valid with two characters." do
      user_with_two_char_name = build(:user, name: "X" * 2)
      expect(user_with_two_char_name).not_to be_valid
    end
    it "is valid with at least 3 characters." do
      user_with_three_char_name = build(:user, name: "X" * 3)
      expect(user_with_three_char_name).to be_valid
    end
    it "is valid with no more than 20 characters" do
      user_with_twenty_char_name = build(:user, name: "X" * 20)
      expect(user_with_twenty_char_name).to be_valid
    end
    it "is not valid with twenty-one characters" do
      user_with_twenty_one_char_name = build(:user, name: "X" * 21)
      expect(user_with_twenty_one_char_name).not_to be_valid
    end

  end

  describe "email" do
    it "must be present." do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).not_to be_valid
    end
    it "must not be a duplicate" do
      user_with_dupe_email = build(:user, email: user.email)
      expect(user_with_dupe_email).not_to be_valid
    end
  end

  describe "password" do
    it "must be present." do
      user_without_password = build(:user, password: nil)
      expect(user_without_password).not_to be_valid
    end
    it "is not valid with five or fewer characters." do
      user_with_five_char_password = build(:user, password: "X" * 5)
      expect(user_with_five_char_password).not_to be_valid
    end
    it "is valid with at least six characters." do
      user_with_six_char_password = build(:user, password: "X" * 6)
      expect(user_with_six_char_password).to be_valid
    end
    it "is valid with no more than sixteen characters" do
      user_with_sixteen_char_password = build(:user, password: "X" * 16)
      expect(user_with_sixteen_char_password).to be_valid
    end
    it "is not valid with seventeen or more characters" do
      user_with_seventeen_char_password = build(:user, password: "X" * 17)
      expect(user_with_seventeen_char_password).not_to be_valid
    end
  end

  describe "secrets" do
    it "are included as a method." do
      expect(user).to respond_to(:secrets)
    end
  end
end

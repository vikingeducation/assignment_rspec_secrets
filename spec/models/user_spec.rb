require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it "is valid with name, email and password" do
    expect(user).to be_valid
  end

  it "saves with default values" do
    expect{ user.save! }.not_to raise_error
  end

  context "name with" do
    it "2 charecters is not valid" do
      new_user = build(:user, name: "12")
      expect(new_user).not_to be_valid
    end

    it "21 charecters is not valid" do
      new_user = build(:user, name: "1" * 21 )
      expect(new_user).not_to be_valid
    end

    it "is valid with 6 charecters" do
      new_user = build(:user, name: "1" * 6)
      expect(new_user).to be_valid
    end

    it "nil value is invalid" do
      new_user = build(:user, name: nil)
      expect(new_user).not_to be_valid
    end
  end

  context "password with" do
    it "7 charecters is  valid" do
      new_user = build(:user, password: "1" * 7)
      expect(new_user).to be_valid
    end

    it "5 charecters is invalid" do
      new_user = build(:user, password: "1" * 5)
      expect(new_user).not_to be_valid
    end

    it "17 charecters is invalid" do
      new_user = build(:user, password: "1" * 17)
      expect(new_user).not_to be_valid
    end
  end
end

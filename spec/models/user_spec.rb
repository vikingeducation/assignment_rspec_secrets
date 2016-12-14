require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  describe "defaults" do

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{user.save!}.not_to raise_error
    end

  end

  describe "invalid attributes" do

    it "requires a name longer than 2 characters" do
      different_user = build(:user, name: "Bo")
      expect(different_user).not_to be_valid
    end

    it "cannot save user with invalid attributes" do
      different_user = build(:user, name: "Bo")
      expect{different_user.save!}.to raise_error
    end

  end

  describe "password" do

    it "requires a password longer than 5 characters" do
      different_user = build(:user, password: "12345" )
      expect(different_user).not_to be_valid
    end

  end

  describe "email uniqueness" do

    before do
      user.save!
    end
    it "cannot save a user unless their email is unique" do
      different_user = build(:user, email: user.email)
      expect{different_user.save!}.to raise_error
    end

  end

  describe "user associations" do

    it "responds to a call to secrets association" do
      expect(user).to respond_to :secrets
    end

  end

end

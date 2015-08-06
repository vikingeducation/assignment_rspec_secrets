# spec/models/user_spec.rb
require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    user.password = nil
    user.password_confirmation = nil
    expect(user).not_to be_valid
  end

  it "is not valid without a password digest" do
    user.password_digest = nil
    expect(user).not_to be_valid
  end

  it "is not valid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is not valid without a name" do
    user.name = nil
    expect(user).not_to be_valid
  end

  describe "name" do

    specify "length cannot be less than 3" do
      user2 = build(:user, :name => "fo")
      expect(user2).not_to be_valid
    end

    specify "length cannot be greater than 20" do
      user2 = build(:user, :name => "foooooooooooooooooooo")
      expect(user2).not_to be_valid
    end

    specify "length can be 3" do
      user2 = build(:user, :name => "foo")
      expect(user2).to be_valid
    end

    specify "length can be up to 20" do
      user3 = build(:user, :name => "fooooooooooooooooooo")
      expect(user3).to be_valid
    end
  end

  describe "email" do

    before do
      user.save
    end

    it "should be unique" do
      user2 = build(:user, email: user.email)
      expect(user2).not_to be_valid
    end

  end

  describe "password" do

    specify "length cannot be less than 6" do
      user2 = build(:user, :password => "foofo", :password_confirmation => "foofo")
      expect(user2).not_to be_valid
    end

    specify "length cannot be greater than 16" do
      user2 = build(:user, :password => "foofofoofofoofofo", :password_confirmation => "foofofoofofoofofo")
      expect(user2).not_to be_valid
    end

    specify "length should be between 6 and 16" do
      user2 = build(:user, :password => "foofoo", :password_confirmation => "foofoo")
      expect(user2).to be_valid

      user3 = build(:user, :password => "foofoofoofooffff", :password_confirmation => "foofoofoofooffff")
      expect(user3).to be_valid
    end
  end

  context "association" do
    it "should respond to secrets" do
      expect(user).to respond_to(:secrets)
    end

    it "can have many secrets" do
      user.secrets = build_list(:secret, 3)
      user.save
      expect(user.secrets.count).to eq(3)
    end
  end
end














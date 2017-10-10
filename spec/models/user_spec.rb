# spec/models/user_spec.rb

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  context "creating a new User" do
    it "is successful with valid attributes"

    it "saves with default attributes"
  end

  context "when saving multiple Users" do
    it "does not allow identical email addresses"
  end

  context "validations" do
    it "ensures the length of a User's name is >= 3 characters"

    it "ensures the length of a User's name is >= 20 characters"

    it "ensures the length of a User's password is >= 6 characters"

    it "ensures the length of a User's password is <= 16 characters"
  end

  context "associations" do
    it "responds to the secrets association"
  end
end

require 'rails_helper'

describe User do

  let(:user1){ build(:user, :with_attributes) }
  let(:user2){ build(:user, :without_attributes) }

  it "is valid with default attributes" do
    expect(user1).to be_valid
  end

  it "is invalid with no attributes" do
    expect(user2).to_not be_valid
  end

  # Password validations.
  it "has a secure password" do 
    is_expected.to have_secure_password
  end

  it "is valid when password has at least 6 characters" do 
    should validate_length_of(:password).is_at_least(6)
  end

  it "is invalid when password has less than 6 characters" do
    new_user = build(:user,password: 'abc')
    expect(new_user).to_not be_valid
  end

  # Email validations
  it "is valid when the email does not yet exist in the database" do
    should validate_uniqueness_of(:email)
  end

  it "is invalid when email already exists in the database" do
    existing_email = user1.email
    new_user = build(:user,password: 'abcdefghij', email: existing_email)
    expect(new_user).to_not be_valid
  end

  # Name validations.
  it "validates name to be greater than 3 characters" do
    should validate_length_of(:name).is_at_least(3)
  end

  it "is invalid when name has less than 3 characters" do
    new_user = build(:user,name: 'a')
    expect(new_user).to_not be_valid
  end

  it "responds to secret association" do
    expect(user1).to respond_to(:secrets)
  end

  it "does not accept invalid data" do
    existing_email = user1.email
    new_user = build(:user,password: 'DROP TABLE users', email: existing_email)
    expect(new_user).to_not be_valid
  end

end

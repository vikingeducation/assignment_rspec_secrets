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

  it "validates password to be greater than 5 characters" do
    new_user = build(:user,password: 'abc')
    expect(new_user).to_not be_valid
  end

  it "is valid when password is greater than 5 characters" do
    expect(user1).to be_valid
  end

  it "is valid when email does not exist in the database" do
    expect(user1).to be_valid
  end

  it "is invalid when email already exists in the database" do
    existing_email = user1.email
    new_user = build(:user,password: 'abcdefghij', email: existing_email)
    expect(new_user).to_not be_valid
  end

  it "validates name to be greater than 3 characters" do
    new_user = build(:user,name: 'a')
    expect(new_user).to_not be_valid
  end

  it "is valid when password is greater than 3 characters" do
    expect(user1).to be_valid
  end

end

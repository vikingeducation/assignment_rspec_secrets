require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "validates all its biz" do
    should validate_presence_of(:name)
    should validate_length_of(:email)
    should validate_length_of(:password).is_at_least(6).is_at_most(16)
  end

  it "is invalid without a name" do
    expect{create(:user, name: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is invalid if it has a non-unique email" do
    user.save
    new_user = build(:user, email: user.email)
    expect(new_user).not_to be_valid
  end

  it "has many secrets" do
    should have_many(:secrets)
  end

  it "requires password & password confirmation to be the same before saving" do
    new_user = build(:user, password: "MarioMario", password_confirmation: "LuigiMario" )
    expect(new_user).not_to be_valid
  end

  it "has a secure password" do
    expect(user).to have_secure_password
  end

end
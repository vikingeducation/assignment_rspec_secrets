require 'rails_helper'

describe User do


  #Basic Validity
  let(:user){build(:user)}

  it "with a name, email and password is valid" do

  end

  it "without a name is invalid" do

  end

  it "without and email is invalid" do

  end

  it "without password is invalid" do

  end

  it "with a duplicate email is invalid" do

  end

  it "returns user name as string" do

  end

  it "returns email as string" do

  end

  it "it saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  it "is valid with default attributes" do
    expect(:user).to be_valid
  end


end

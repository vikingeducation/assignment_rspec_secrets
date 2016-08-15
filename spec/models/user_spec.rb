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
    
  end

end
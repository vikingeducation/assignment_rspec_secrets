require 'rails_helper'

describe Secret do

  let(:secret1){ build(:secret, :with_attributes)}
  let(:secret2){ build(:secret, :without_attributes)}

  it "is valid with default attributes" do
    expect(secret1).to be_valid
  end

  it "is invalid without default attributes" do
    expect(secret2).to_not be_valid
  end

  it "validates for title length (greater than 3 characters)" do
    new_secret = build(:secret, :with_attributes, :title => "hi")
    expect(new_secret).to_not be_valid
  end

  it "validates for body length (greater than 3 characters)" do
    new_secret = build(:secret, :with_attributes, :body => "hi")
    expect(new_secret).to_not be_valid
  end
  
end
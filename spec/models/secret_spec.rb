require 'rails_helper'

describe Secret do

  let(:secret){ build(:secret) }

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "saves with default values" do
    expect{ secret.save! }.not_to raise_error
  end

  
end

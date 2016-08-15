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

  # Title validations.
  it "is valid when title is greater than 3 characters" do
    should validate_length_of(:title).is_at_least(4)
  end

  it "is invalid when title has less than 4 characters" do
    new_secret = build(:secret, :with_attributes, :title => "hi")
    expect(new_secret).to_not be_valid
  end

  it "validates for body length (greater than 3 characters)" do
    new_secret = build(:secret, :with_attributes, :body => "hi")
    expect(new_secret).to_not be_valid
  end

  describe "#last_five" do
    it "returns the last five records in the table" do
      expect(Secret.last_five.count).to be <= 5
    end

    it "returns the last five records in the table in descending order" do
      five = Secret.last_five
      last = five[-1]
      if second_to_last = five[-2]
        expect(last.created_at).to be <= second_to_last.created_at
      end
    end

  end
  
end
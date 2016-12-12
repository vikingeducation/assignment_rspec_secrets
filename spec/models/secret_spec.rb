require 'rails_helper'

describe Secret do

  let(:secret) { build(:secret) }

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "rejects secrets without body or title" do
    expect{create(:secret, title: "")}.to raise_error(ActiveRecord::RecordInvalid)
    expect{create(:secret, body: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates all its biz" do
    should validate_presence_of(:title)
    should validate_length_of(:title)
    should validate_length_of(:body)
  end

  it "belongs to an author" do
    should belong_to(:author)
  end

  describe ".last_five" do
    it "returns the 5 most recent secrets" do
      secret_list = create_list(:secret, 10)

      expect( Secret.last_five ).to eq(secret_list[5..9].reverse)
    end

    it "returns an empty array if there aren't any secrets" do
      expect( Secret.last_five ).to eq []
    end
  end

end
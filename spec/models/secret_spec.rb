require 'rails_helper'

describe Secret do

  let(:secret) { build(:secret) }

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "is rejects secrets without body, title, or author" do
    secret = create(:secret, title: "")
    expect
  end

  it "validates all its biz" do
    should validate_presence_of(:title)
    should validate_length_of(:title)
    should validate_length_of(:body)
  end

  # it "belong to an author" do
  #   should belong_to(:author)
  # end

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

# Validation

# describe Artist do
#   let(:artist) { create(:artist) }

#   # ----------------------------------------
#   # Validations
#   # ----------------------------------------

#   it do
#     should validate_presence_of(:name)
#   end

#   # ----------------------------------------
#   # Associations
#   # ----------------------------------------

#   it do
#     should have_many(:songs)
#   end


#   it do
#     should have_many(:bookmarks).dependent(:destroy)
#   end
# end

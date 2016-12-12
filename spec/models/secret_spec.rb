require 'rails_helper'

describe Secret do

  let(:secret) { build(:secret) }

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "validates all its biz" do
    should validate_presence_of(:title)
    should validate_length_of(:title)
    should validate_length_of(:body)
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
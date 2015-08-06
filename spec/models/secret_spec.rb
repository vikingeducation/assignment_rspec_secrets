require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }

  it "is valid with default attributes"

  it "saves with default attributes"

  it "does not save without a title"

  it "does not save without a body"

  it "does not save without a author"

  it "does not save if the title is less than 4 characters"

  it "does not save if title is more than 24 characters"

  it "does not save if body is less than 4 characters"

  it "does not save if body is more than 140 characters"

  it "responds to author assosciation"

  describe "#last_five" do

    it "shows the last 5 secrets created" do
      create_list(:secret, 10)
      expect(secret.last_five).count.to eq(5)
    end
  end

end
require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }

  it "is valid with title and body" do
    expect(secret).to be_valid
  end

  it "responds to author" do
    expect(secret).to respond_to(:author)
  end

  it "saves with default values" do
    expect{ secret.save! }.not_to raise_error
  end

  context "when title with" do
    it "3 charecters given is not valid" do
      new_secret = build(:secret, title: "a" * 3)
      expect(new_secret).not_to be_valid
    end

    it "25 charecters given is not valid" do
      new_secret = build(:secret, title: "a" * 25)
      expect(new_secret).not_to be_valid
    end

    it "6 charecters given it is valid" do
      new_secret = build(:secret, title: "a" * 6)
      expect(new_secret).to be_valid
    end
  end
end

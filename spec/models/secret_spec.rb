require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "saves with default attributes" do
    expect{ secret.save! }.not_to raise_error
  end

  it "secret has a title that is not blank" do
    expect(secret.title).not_to eq("")
  end

  it "secret body has the right number of characters" do
    expect(secret.body).not_to eq("")
  end

  it "secret body has to be the correct length" do
    expect(secret.body.length).to be_between(4,140)
  end

  describe "secret associations" do
     it "responds to the secrets association" do
      expect(secret).to respond_to(:author)
    end
  end

  it "linking nonexistent author fails" do
    secret.author_id = 1234
    expect( secret ).not_to be_valid
  end
end
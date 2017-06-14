require "rails_helper"

describe Secret do
  let(:secret){ build(:secret) }

  it "is saves with all required fields given" do
    expect(secret).to be_valid
  end

  it "responds to the `author` association" do
    expect(secret).to respond_to(:author)
  end

  context "presence validation" do
    it "fails if a title is not given" do
      secret.title = nil
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails if a body is not given" do
      secret.body = nil
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails if an author is not present" do
      secret.author = nil
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context "length validation" do
    it "is valid if title is between 4..24 chars" do
      secret.title = make_string("a", rand(4..24))
      expect{ secret.save! }.not_to raise_error
    end

    it "is valid if body is between 4..140 chars" do
      secret.body = make_string("a", rand(4..140))
      expect{ secret.save! }.not_to raise_error
    end

    it "fails if title is < 4 chars" do
      secret.title = make_string("a", 3)
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails if title is > 24 chars" do
      secret.title = make_string("a", 25)
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails if body is < 4 chars" do
      secret.body = make_string("a", 3)
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails if body is > 140 chars" do
      secret.body = make_string("a", 141)
      expect{ secret.save! }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context "custom methods" do

    it "returns the five last secrets created" do
      create_list(:secret, 10)
      last_five = Secret.last_five
      expect(last_five.first.id).to be > last_five.last.id
    end

  end


end

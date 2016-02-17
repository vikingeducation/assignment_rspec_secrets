require 'rails_helper'

describe Secret do

  let(:user) { create(:user) }
  let(:secret) { build(:secret, author: user) }

  describe :attributes do
    it "is valid with default attributes" do
      expect(secret).to be_valid
    end

    it "saves with default attributes" do
      expect { secret.save! }.to_not raise_error
    end

    it "is invalid without a title" do
      new_secret = build(:secret, title: nil)
      expect(new_secret).to be_invalid
    end

    it "is invalid without a body" do
      new_secret = build(:secret, body: nil)
      expect(new_secret).to be_invalid
    end

    it "is invalid without an author" do
      new_secret = build(:secret, author: nil)
      expect(new_secret).to be_invalid
    end

    it "title is too short" do
      new_secret = build(:secret, title: "hi")
      expect(new_secret).to be_invalid
    end

    it "title is too long" do
      new_secret = build(:secret, title: "a" * 25)
      expect(new_secret).to be_invalid
    end

    it "body is too short" do
      new_secret = build(:secret, body: "hi")
      expect(new_secret).to be_invalid
    end

    it "body is too long" do
      new_secret = build(:secret, body: "a" * 141)
      expect(new_secret).to be_invalid
    end

  end

  describe "Author associations" do
    before do
      secret.save!
    end

    specify "linking to a valid Author succeeds" do
      author = create( :user, email: "assocation_test@example.com" )
      secret.author = author
      expect( secret ).to  be_valid
    end

    specify "linking nonexistence author fails" do
      secret.author_id = 99999
      expect( secret ).to_not be_valid
    end

  end

  describe "#last_five" do
    it "returns last five secrets in database" do
    end

    it ""
  end
end

require 'rails_helper'
describe Secret do
  let(:secret){build(:secret)}
  describe "attributes" do
    context "title" do
      it "is valid with a title" do
        expect(secret).to be_valid
      end

      it "is invalid without a title" do
        expect(build(:secret, title: nil)).to_not be_valid
      end

      it "is valid with a title between 4 and 24 characters long" do
        expect(secret).to be_valid
      end

      it "is invalid with a title less than 4 characters long" do
        expect(build(:secret, title: "123")).to_not be_valid
      end

      it "is invalid with a title more than 24 characters long" do
        expect(build(:secret, title: "1234567890123456789012345")).to_not be_valid
      end
    end

    context "body" do
      it "is invalid without a body" do
        expect(build(:secret, body: nil)).to_not be_valid
      end

      it "is invalid with a body less than 4 characters long" do
        expect(build(:secret, body: "123")).to_not be_valid
      end

      it "is invalid with a body more than 140 characters long" do
        expect(build(:secret, body: "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890")).to_not be_valid
      end

      it "is valid with a body between 4 and 140 characters long" do
        expect(build(:secret, body: "12345678901234567890")).to be_valid
      end
    end

    context "author" do
      it "is invalid without an author" do
        expect(build(:secret, author: nil)).to_not be_valid
      end
    end
  end

  describe "associations" do
    it "responds to author" do
      expect(secret).to respond_to(:author)
    end
  end
end
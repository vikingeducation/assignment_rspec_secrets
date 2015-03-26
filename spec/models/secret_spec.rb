require 'rails_helper'
require 'pry'

describe Secret do
  let(:secret){ build(:secret)}

  describe "is complete" do
    it "with a title, body and author." do
      expect(secret).to be_valid
    end
  end

  describe "title" do
    it "must be present." do
      secret_without_title = build(:secret, title: nil)
      expect(secret_without_title).not_to be_valid
    end
    it "is not valid with three or fewer characters." do
      secret_with_3_char_title = build(:secret, title: "X" * 3)
      expect(secret_with_3_char_title).not_to be_valid
    end
    it "is valid with at least four characters." do
      secret_with_4_char_title = build(:secret, title: "X" * 4)
      expect(secret_with_4_char_title).to be_valid
    end
    it "is valid with up to twenty-four characters." do
      secret_with_24_char_title = build(:secret, title: "X" * 24)
      expect(secret_with_24_char_title).to be_valid
    end
    it "is not valid with twenty-five or more characters." do
      secret_with_25_char_title = build(:secret, title: "X" * 25)
      expect(secret_with_25_char_title).not_to be_valid
    end
  end

  describe "body" do
    it "must be present." do
      secret_without_body = build(:secret, body: nil)
      expect(secret_without_body).not_to be_valid
    end
    it "is not valid with three or fewer characters." do
      secret_with_3_char_body = build(:secret, body: "X" * 3)
      expect(secret_with_3_char_body).not_to be_valid
    end
    it "is valid with at least four characters." do
      secret_with_4_char_body = build(:secret, body: "X" * 4)
      expect(secret_with_4_char_body).to be_valid
    end
    it "is valid with up to 140 characters." do
      secret_with_140_char_body = build(:secret, body: "X" * 140)
      expect(secret_with_140_char_body).to be_valid
    end
    it "is not valid with 141 or more characters." do
      secret_with_141_char_body = build(:secret, body: "X" * 141)
      expect(secret_with_141_char_body).not_to be_valid
    end
  end

  describe "author" do
    it "must be present." do
      secret_without_author = build(:secret, author: nil)
      expect(secret_without_author).not_to be_valid
    end
    it "is available as a method." do
      expect(secret).to respond_to(:author)
    end
  end
end
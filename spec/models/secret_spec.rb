require 'rails_helper'

describe Secret do

  describe "Validates" do

    let(:secret) {build(:secret)}

    it "it is invalid without a body" do
      no_body = build(:secret, body: "")
      expect(no_body).to_not be_valid
    end

    it "it is invalid without a title" do
      no_title = build(:secret, title: "")
      expect(no_title).to_not be_valid
    end

    it "it is invalid if there is a short title" do
      short_title = build(:secret, title: "aaa")
      expect(short_title).to_not be_valid
    end


    it "it is invalid if there is a long title" do
      long_title = build(:secret, title: "a" * 25)
      expect(long_title).to_not be_valid
    end

    it "it is invalid if there is a short body" do
      short_body = build(:secret, body: "1")
      expect(short_body).to_not be_valid
    end

    it "it is invalid if there is a long body" do
      long_body = build(:secret, body: "a" * 200)
      expect(long_body).to_not be_valid
    end

    it "it is valid with default attributes" do
      expect(secret).to be_valid
    end
  end


  describe "Associations with users" do
    let(:user) { build(:user) }
    let(:secret) {build(:secret) }

    it "has an associated author" do
      expect(secret).to respond_to(:author)
    end

    it "an author to be associated with a specific secret" do
      secret.author = user
      expect(secret).to be_valid
    end

    it "is invalid with a unreal author" do
      secret.author_id = "laksdjf"
      expect(secret).to_not be_valid
    end
  end

  describe "#last_five" do
    it "returns five secrets" do
      10.times do
        create(:secret)
      end
      expect(Secret.last_five.count).to eq(5)
    end
  end

end

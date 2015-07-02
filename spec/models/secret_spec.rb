require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }
  describe "attribute" do
    it "all pass when a title, body, and author id are within constraints" do
      expect(secret).to be_valid
    end

    describe "title" do
      it "is invalid when blank" do
        new_secret = build(:secret, title: nil)
        expect{ new_secret.save! }.to raise_error(/Title can't be blank/)
      end
      it "is invalid if <4 or >24 characters long" do
        new_secret_short = build(:secret, title: "No")
        new_secret_long = build(:secret, title: "F" * 25)
        expect(new_secret_short).to_not be_valid
        expect(new_secret_long).to_not be_valid
      end
      it "is valid if exactly 4 or 24 characters long" do
        new_secret_exact_lower = build(:secret, title: "ayyy")
        new_secret_exact_upper = build(:secret, title: "ayy lmao" * 3)
        expect(new_secret_exact_lower).to be_valid
        expect(new_secret_exact_upper).to be_valid
      end
    end

    describe "body" do
      it "is invalid when blank" do
        new_secret = build(:secret, body: nil)
        expect{ new_secret.save! }.to raise_error(/Body can't be blank/)
      end
      it "is invalid if <4 or >140 characters long" do
        new_secret_short = build(:secret, body: "No")
        new_secret_long = build(:secret, body: "F" * 141)
        expect(new_secret_short).to_not be_valid
        expect(new_secret_long).to_not be_valid
      end
      it "is valid if exactly 4 or 140 characters long" do
        new_secret_exact_lower = build(:secret, body: "ayyy")
        new_secret_exact_upper = build(:secret, body: "a" * 140)
        expect(new_secret_exact_lower).to be_valid
        expect(new_secret_exact_upper).to be_valid
      end
    end

    describe "author" do
      it "is invalid when not present" do
        new_secret = build(:secret, author_id: nil)
        expect(new_secret).to_not be_valid
      end
    end

  end

  describe "associations" do
    it "responds to the authors association" do
      expect(secret).to respond_to(:author)
    end
  end

  describe "methods" do
    describe "#last_five" do
      let(:num_secrets){ 5 }
      before do
        num_secrets.times do
          create(:secret)
        end
      end

      it "returns the last five secrets" do
        expect(Secret.last_five.count).to eq(num_secrets)
      end
    end
  end

end

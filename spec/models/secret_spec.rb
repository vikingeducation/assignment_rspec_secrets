# spec/models/secret_spec.rb

require 'rails_helper'

describe Secret do
  let(:secret) { build(:secret) }

  context "creating a new Secret:" do
    it "is valid with default attributes" do
      expect(secret).to be_valid
    end

    it "saves with default attributes" do
      expect { secret.save! }.not_to raise_error
    end
  end

  context "validations:" do
    it "ensures the length of a Secret's title is >= 4 characters" do
      secret.title = "a" * 3
      expect(secret).not_to be_valid
    end

    it "ensures the length of a Secret's title is < 24 characters" do
      secret.title = "a" * 25
      expect(secret).not_to be_valid
    end

    it "ensures the length of a Secret's body is >= 4 characters" do
      secret.body = "a" * 3
      expect(secret).not_to be_valid
    end

    it "ensures the length of a Secret's body is < 140 characters" do
      secret.body = "a" * 141
      expect(secret).not_to be_valid
    end
  end

  context "associations:" do
    it "responds to the author association" do
      expect(secret).to respond_to(:author)
    end
  end

  context "class methods:" do
    context "Secret::last_five" do
      it "returns 5 Secrets if there are only 5 available Secrets" do
        5.times { create(:secret) }
        secrets = Secret.last_five
        expect(secrets.length).to eq(5)
      end

      it "returns all Secrets if there are < 5 available Secrets" do
        4.times { create(:secret) }
        secrets = Secret.last_five
        expect(secrets.length).to eq(4)
      end

      it "returns the latest 5 Secrets if there are >5 Secrets available" do
        6.times { create(:secret) }
        secrets = Secret.last_five
        first_secret = Secret.order(:id).first

        expect(secrets.all? { |secret| secret.id > first_secret.id }).to be true
      end
    end
  end
end

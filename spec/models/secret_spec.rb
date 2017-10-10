# spec/models/secret_spec.rb

require 'rails_helper'

describe Secret do
  let(:secret) { build(:secret) }

  context "creating a new Secret:" do
    it "is valid with default attributes"

    it "saves with default attributes"
  end

  context "validations:" do
    it "ensures the length of a Secret's title is >= 4 characters"

    it "ensures the length of a Secret's title is < 24 characters"

    it "ensures the length of a Secret's body is >= 4 characters"

    it "ensures the length of a Secret's body is < 140 characters"
  end

  context "associations:" do
    it "responds to the author association"
  end

  context "class methods:" do
    context "Secret::last_five" do
      it "returns all Secrets if there are <= 5 Secrets available"

      it "returns the latest 5 Secrets if there are >5 Secrets available"
    end
  end

end

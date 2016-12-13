require 'rails_helper'

describe Secret do
  let(:user){ build(:user) }
  let(:secret){ build(:secret) }
  let(:num_secrets){ 5 }

  describe "defaults"

    it "is valid with default attributes" do
      expect(secret).to be_valid
    end

    it "saves with default attributes" do
      expect{secret.save!}.not_to raise_error
    end

  describe "Secret associations" do

    it "is linked to an author" do
      expect(secret).to respond_to(:author)
    end

    it "is linked to an author" do
      user2 = build(:user)
      expect(secret.id).to_not eq(user2)
    end

  end

  describe "#last_five" do

    it "returns a users last 5 secrets" do
      secrets = create_list(:secret, 7)
      expect(Secret.last_five).to match_array(secrets[2..6])
    end

  end

end

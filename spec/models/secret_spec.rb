require 'rails_helper'

describe Secret do
  let(:user){ build(:user) }
  let(:secret){ build(:secret) }
  let(:num_secrets){ 5 }

  describe "Secret associations" do
    it ("is linked to an author") do
      expect(secret).to respond_to(:author)
    end
  end

  it "is linked to an author" do
    user2 = build(:user)
    expect(secret.id).to_not eq(user2)
  end

  describe "#last_five" do
    it "returns a users last 5 secrets" do
      secrets = create_list(:secret, 7)
      expect(Secret.last_five).to match_array(secrets[2..6])
    end
  end
end

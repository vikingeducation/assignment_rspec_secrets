require 'rails_helper'

describe Secret do
  let(:user){ build(:user) }
  let(:secret){ build(:secret) }
  let(:num_secrets){ 5 }

  describe "#last_five"
    before do
      secrets = create_list(:secret, 7)
    end
    it "returns a users last 5 secrets" do
      expect(secret.last_five).to eq(num_secrets)
    end
end

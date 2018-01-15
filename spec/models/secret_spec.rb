require 'rails_helper'

RSpec.describe Secret, type: :model do
  let(:secret){ build(:secret) }
  let(:title_min){ 4 }
  let(:title_max){ 24 }
  let(:body_min){ 4 }
  let(:body_max){ 140 }

  describe 'basic validity' do
    it 'test basic validity of secrets'
  end

  describe "valdations" do
    it "with a title, body, and author is valid" do
      expect(secret).to be_valid
    end

    it "without an author is invalid" do
      secret = build(:secret, author: nil)
      expect(secret).not_to be_valid
    end

    it "without a title is invalid" do
      secret = build(:secret, title: nil)
      expect(secret).not_to be_valid
    end

    it "with a title that's in the length range is valid" do
      secret_1 = build(:secret, title: generate_string(title_min))
      secret_2 = build(:secret, title: generate_string(title_max))
      expect([secret_1, secret_2]).to all(be_valid)
    end

    it "with a title that's too short is invalid" do
      secret = build(:secret, title: generate_string(title_min - 1))
      expect(secret).not_to be_valid
    end

    it "with a title that's too long is invalid" do
      secret = build(:secret, title: generate_string(title_max + 1))
      expect(secret).not_to be_valid
    end

    it "without a body is invalid" do
      secret = build(:secret, body: nil)
      expect(secret).not_to be_valid
    end

    it "with a body that's in the length range is valid" do
      secret_1 = build(:secret, body: generate_string(body_min))
      secret_2 = build(:secret, body: generate_string(body_max))
      expect([secret_1, secret_2]).to all(be_valid)
    end

    it "with a body that's too short is invalid" do
      secret = build(:secret, body: generate_string(body_min - 1))
      expect(secret).not_to be_valid
    end

    it "with a body that's too long is invalid" do
      secret = build(:secret, body: generate_string(body_max + 1))
      expect(secret).not_to be_valid
    end

  end

  describe 'associations' do
    it "responds to #author" do
      expect(secret).to respond_to(:author)
    end
  end

  describe 'model methods' do
    describe '.last_five' do

      let(:expected_secrets){ 5 }

      before do
        create_list(:secret, expected_secrets + 1)
      end

      it "returns the last 5 secrets" do
        expect(Secret.last_five.count).to eq(expected_secrets)
      end
    end
  end

end

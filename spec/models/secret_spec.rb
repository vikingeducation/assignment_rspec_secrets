require 'rails_helper'

RSpec.describe Secret, type: :model do
  let(:secret){ build(:secret) }

  def generate_string(qty)
    str = ''
    qty.times { str += 'x' }
    str
  end

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

    it "with a title that's too short is invalid" do
      secret = build(:secret, title: generate_string(3))
      expect(secret).not_to be_valid
    end

    it "with a title that's too long is invalid" do
      secret = build(:secret, title: generate_string(25))
      expect(secret).not_to be_valid
    end

    it "without a body is invalid" do
      secret = build(:secret, body: nil)
      expect(secret).not_to be_valid
    end

    it "with a body that's too short is invalid" do
      secret = build(:secret, body: generate_string(3))
      expect(secret).not_to be_valid
    end

    it "with a body that's too long is invalid" do
      secret = build(:secret, body: generate_string(141))
      expect(secret).not_to be_valid
    end

  end

  describe 'associations' do
  end

  describe 'model methods' do
  end

end

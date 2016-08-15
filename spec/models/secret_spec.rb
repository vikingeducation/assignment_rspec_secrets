require 'rails_helper'

describe 'Secret' do
    let(:secret) { build(:secret) }

  # Validations
    it "is valid with default attributes" do
      expect(secret).to be_valid
    end

    it "saves with default attributes" do
      expect{ secret.save }.to_not raise_error
    end

    it "is not valid if title is empty/nil" do
      new_secret = build(:secret, title: nil)
      expect(new_secret.valid?).to eq(false)
    end

    it "is not vaild if title length is greater than 24 or less than 4" do
      new_secret1 = build(:secret, :title => "a" * 25)
      expect(new_secret1.valid?).to eq(false)
      new_secret2 = build(:secret, :title => "a" * 3)
      expect(new_secret2.valid?).to eq(false)
    end

    it "is not vaild if body length is greater than 140 or less than 4" do
     new_secret1 = build(:secret, :body => "a" * 141)
      expect(new_secret1.valid?).to eq(false)
      new_secret2 = build(:secret, :body => "a" * 3)
      expect(new_secret2.valid?).to eq(false)
    end

  # Associations
  it "responds to author" do
    expect{ secret.author }.to_not raise_error
  end

  # Methods
  describe "#last_five" do
    before { create_list(:secret, 10) }
    it "returns five secrets" do


      expect(Secret.last_five.count).to eq(5)
    end

    it "orders in secrets in descending order by id" do
      ids = Secret.last_five.pluck(:id)
      expect(Secret.pluck(:id).sort.reverse[0..4]).to eq(ids)
    end
  end
end
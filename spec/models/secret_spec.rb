require 'rails_helper'

describe Secret do
  let(:secret){build(:secret)}

  it "build a valid secret" do
    expect(secret).to be_valid
  end

  it "saves properly" do
    expect{ secret.save! }.not_to raise_error
  end

  it "validates title" do
    secret = build(:secret, title: "")
    expect{secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "belongs to an author" do
    expect(secret).to respond_to(:author)
  end

  describe "#last_five" do
    let!(:secrets){create_list(:secret, 5)}
    # before do
    #   secrets = create_list(:secret, 5)
    # end
    it "returns 5 secrets" do
      expect(Secret.last_five.count).to eq(5)
    end

    it "returns secrets in descending order" do
      expect(Secret.last_five.first).to eq(secrets.last)
    end
  end

 end
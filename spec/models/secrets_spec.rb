require 'rails_helper'

describe Secret do

  let(:valid){ build(:secret) }
  let(:short_title){ build(:secret, title: "fff") }
  let(:long_title){ build(:secret, title: "#{'a'*25}") }
  let(:short_body){ build(:secret, body: "#{'a'*3}") }
  let(:long_body){ build(:secret, body: "#{'a'*141}") }
  let(:no_author){ build(:secret, author_id: nil) }

  it { should belong_to :author }

  it "accepts a valid title" do
    expect(short_title).to_not be_valid
    expect(long_title).to_not be_valid
  end

  it "requires a valid body" do
    expect(short_body).to_not be_valid
    expect(long_body).to_not be_valid
  end

  it "requires an :author" do
    expect(no_author).to_not be_valid
  end
  describe ".last_five" do
    it "returns at most 5 secrets" do
      7.times do
        s = create(:secret)
      end

      expect(Secret.last_five.count).to be <= 5
    end

    it "returns the last 5 secrets" do
      s = []
      7.times do |n|
        s[n] = create(:secret)
      end

      expect(Secret.last_five).to eq(s[-5..-1].reverse)
    end


  end
end

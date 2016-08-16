require 'rails_helper'

describe Secret do

  describe "Validates" do

    let(:secret) {build(:secret)}

    it "it is invalid without a body" do
      no_body = build(:secret, body: "")
      expect(no_body).to_not be_valid
    end

    it "it is invalid without a title" do
      no_title = build(:secret, title: "")
      expect(no_title).to_not be_valid
    end

    it "it is invalid if there is a short title" do
      short_title = build(:secret, title: "aaa")
      expect(short_title).to_not be_valid
    end


    it "it is invalid if there is a long title" do
      long_title = build(:secret, title: "a" * 25)
      expect(long_title).to_not be_valid
    end

    it "it is invalid if there is a short body" do
      short_body = build(:secret, body: "1")
      expect(short_body).to_not be_valid
    end

    it "it is invalid if there is a long body" do
      long_body = build(:secret, body: "a" * 200)
      expect(long_body).to_not be_valid
    end

    it "it is valid with default attributes" do
      expect(secret).to be_valid
    end
  end


  describe "Associations with users" do
    let(:user) { build(:user) }
    let(:secret) {build(:secret) }

    it "has an associated author" do
      expect(secret).to respond_to(:author)
    end

    it "has one author" do 
      is_expected.to belong_to(:author)
    end

    it "an author to be associated with a specific secret" do
      secret.author = user
      expect(secret).to be_valid
    end

    it "is invalid with a unreal author" do
      secret.author_id = "laksdjf"
      expect(secret).to_not be_valid
    end
  end

  describe "#last_five" do
    it "returns five secrets" do
      10.times do
        create(:secret)
      end
      expect(Secret.last_five.count).to eq(5)
    end

    it "returns only two secrets if there are only two" do 
      2.times do 
        create(:secret)
      end
       expect(Secret.last_five.count).to eq(2)
     end

  let(:secret){ build(:secret) }

  it 'with a title, body, and author is valid' do
    expect(secret).to be_valid
  end

  it 'without a title is invalid' do
    new_secret = build(:secret, title: nil)
    expect(new_secret).not_to be_valid
  end

  it 'without a body is invalid' do
    new_secret = build(:secret, body: nil)
    expect(new_secret).not_to be_valid
  end

  it 'without an author is invalid' do
    new_secret = build(:secret, author: nil)
    expect(new_secret).not_to be_valid
  end

  context "validation of attributes" do
    it 'does not allow a title of length < 4' do
        new_secret = build(:secret, title: "a"*3)
        expect(new_secret).not_to be_valid
    end

    it 'does not allow a title of length > 24' do
        new_secret = build(:secret, title: "a"*25)
        expect(new_secret).not_to be_valid
    end

    it 'does not allow a body of length < 4' do
        new_secret = build(:secret, body: "a"*3)
        expect(new_secret).not_to be_valid
    end

    it 'does not allow a title of length > 140' do
        new_secret = build(:secret, title: "a"*141)
        expect(new_secret).not_to be_valid
    end
  end

  context "model methods" do

    it 'retrieves the last five created secrets' do
      first_secret = create(:secret)
      last_five_secrets = create_list(:secret, 5)
      expect(Secret.last_five).to match_array(last_five_secrets)
    end
  end

end

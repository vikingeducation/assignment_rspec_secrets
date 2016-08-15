require 'rails_helper'

describe Secret do

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

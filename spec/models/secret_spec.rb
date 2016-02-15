require 'rails_helper'

RSpec.describe Secret, :type => :model do

  let(:secret){ build(:secret) }

  context "validations" do

    it 'is valid with a title, body, and author' do
      expect(secret).to be_valid
    end

    it 'is invalid without a title' do
      secret = build(:secret, title: nil)
      expect(secret).to_not be_valid
    end

    it 'is invalid without a body' do
      secret = build(:secret, body: nil)
      expect(secret).to_not be_valid
    end

    it 'is invalid without an author' do
      secret = build(:secret, author_id: nil)
      expect(secret).to_not be_valid
    end

    it 'is invalid with a title less than 4 characters' do
      secret = build(:secret, title: "123")
      expect(secret).to_not be_valid
    end

    it 'is invalid with a title more than 24 characters' do
      secret = build(:secret, title: ("x" * 25))
      expect(secret).to_not be_valid
    end

    it 'is invalid with a body less than 4 characters' do
      secret = build(:secret, body: "123")
      expect(secret).to_not be_valid
    end

    it 'is invalid with a body more than 140 characters' do
      secret = build(:secret, body: ("x" * 141))
      expect(secret).to_not be_valid
    end

  end

  context 'associations' do

    it 'responds to the author association' do
      expect(secret).to respond_to(:author)
    end

    it 'is invalid with an invalid author' do
      secret.author_id = 12345
      expect(secret).to_not be_valid
    end

    it 'is valid with a valid author' do
      author = create(:user)
      secret.author = author
      expect(secret).to be_valid
    end
  end
end
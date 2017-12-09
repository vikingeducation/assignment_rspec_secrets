require 'rails_helper'

RSpec.describe Secret, type: :model do
  it 'is valid with title, body, and author' do
    secret = build :secret
    expect(secret).to be_valid
  end

  it 'is invalid without an author' do
    secret = build :secret, author: nil
    secret.valid?
    expect(secret.errors[:author]).to include "can't be blank"
  end

  describe 'title' do
    it 'is invalid without' do
      secret = build :secret, title: nil
      secret.valid?
      expect(secret.errors[:title]).to include "can't be blank"
    end

    it 'is invalid if too short' do
      secret = build :secret, title: 'foo'
      secret.valid?
      expect(secret.errors[:title]).to include 'is too short (minimum is 4 characters)'
    end

    it 'is invalid if too long' do
      secret = build :secret, title: 'Blah' * 7
      secret.valid?
      expect(secret.errors[:title]).to include 'is too long (maximum is 24 characters)'
    end
  end

  describe 'body' do
    it 'is invalid without' do
      secret = build :secret, body: nil
      secret.valid?
      expect(secret.errors[:body]).to include "can't be blank"
    end

    it 'is invalid if too short' do
      secret = build :secret, body: 'foo'
      secret.valid?
      expect(secret.errors[:body]).to include 'is too short (minimum is 4 characters)'
    end

    it 'is invalid if too long' do
      secret = build :secret, body: 'Boblobla' * 18
      secret.valid?
      expect(secret.errors[:body]).to include 'is too long (maximum is 140 characters)'
    end
  end

  describe '#last_five' do
    it 'returns 5 secrets' do
      create_list :secret, 6
      expect(Secret.last_five.size).to eq 5
    end

    it 'returns them in descending order of ID' do
      ordered_list = create_list(:secret, 5).reverse
      expect(Secret.last_five).to match ordered_list
    end
  end
end
# Test basic validity
# Test that you can't create without an author
# Test title, body presence + parameters
# Test last_five class method

require 'rails_helper'

describe Secret do
  let(:user){ build(:user) }
  let(:secret){ build(:secret) }

  describe 'attributes' do
    it 'Default secret creation works' do
      expect(secret).to be_valid
    end

    it 'Does not work if title is blank' do
      new_secret = build(:secret, title: "")
      expect(new_secret).not_to be_valid
    end

    it 'Does not work if body is blank' do
      new_secret = build(:secret, body: "")
      expect(new_secret).not_to be_valid
    end

    it 'Does not work if author is blank' do
      new_secret = build(:secret, author: nil)
      expect(new_secret).not_to be_valid
    end

    it 'Is valid with title length 4' do
      new_secret = build(:secret, title: 'Test')
      expect(new_secret).to be_valid
    end

    it 'Is valid with title length 24' do
      new_secret = build(:secret, title: 'Testtesttesttesttesttest')
      expect(new_secret).to be_valid
    end

    it 'Is invalid with title length 25' do
      new_secret = build(:secret, title: 'Testtesttesttesttesttestt')
      expect(new_secret).not_to be_valid
    end

    it 'Is valid with body length 4' do
      new_secret = build(:secret, body: 'Test')
      expect(new_secret).to be_valid
    end

    it 'Is valid with body length 104' do
      new_secret = build(:secret, body: 'T' * 140)
      expect(new_secret).to be_valid
    end

    it 'Is invalid with body length 141' do
      new_secret = build(:secret, body: 'T' * 141)
      expect(new_secret).not_to be_valid
    end
  end

  describe 'associations' do
    before do
      secret.save!
    end

    it 'responds to author' do
      expect(secret).to respond_to(:author)
    end
  end

end
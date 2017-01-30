require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }

  describe 'default validations' do
    it 'with default attributes valid' do
      expect(secret).to be_valid
    end

    it 'saves default attributes without error' do
      expect{ secret.save! }.not_to raise_error
    end
  end

  describe 'title validations' do
    it 'without title is invalid' do
      secret = build(:secret, :title => nil)
      expect(secret).not_to be_valid
    end

    it 'with title of 3 characters is invalid' do
      secret = build(:secret, :title => 'aaa')
      expect(secret).not_to be_valid
    end

    it 'with title of 4 characters is valid' do
      secret = build(:secret, :title => 'aaaa')
      expect(secret).to be_valid
    end

    it 'with title of 25 characters is invalid' do
      secret = build(:secret, :title => 'a' * 25)
      expect(secret).not_to be_valid
    end

    it 'with title of 24 characters is valid' do
      secret = build(:secret, :title => 'a' * 24)
      expect(secret).to be_valid
    end
  end

  describe 'body validations' do
    it 'without body is invalid' do
      secret = build(:secret, :body => nil)
      expect(secret).not_to be_valid
    end

    it 'with body of 3 characters is invalid' do
      secret = build(:secret, :body => 'a' * 3)
      expect(secret).not_to be_valid
    end

    it 'with body of 4 characters is valid' do
      secret = build(:secret, :body => 'a' * 4)
      expect(secret).to be_valid
    end

    it 'with body of 141 characters is invalid' do
      secret = build(:secret, :body => 'a' * 141)
      expect(secret).not_to be_valid
    end

    it 'with body of 140 characters is valid' do
      secret = build(:secret, :body => 'a' * 140)
      expect(secret).to be_valid
    end
  end

  describe 'author associations' do
    it 'responds to author association' do
      expect(secret).to respond_to(:author)
    end
 
    it 'without author is invalid' do
      secret = build(:secret, :author => nil)
      expect(secret).not_to be_valid
    end

    it 'linking a valid author succeeds' do
      author = create(:user)
      secret.author = author
      expect(secret).to be_valid
    end

    it 'linking a nonexistent author fails' do
      secret.author_id = nil
      expect(secret).not_to be_valid
    end
  end

  describe '#last_five' do
    before do
      create_list(:secret, 5)
    end

    it 'returns five secrets' do
      expect(Secret.last_five.size).to eq(5)
    end

    it 'returns secrets in descending order' do
      expect(Secret.last_five.last).to eq(Secret.first)
    end
  end

end
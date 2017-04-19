require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }
  describe 'default attributes' do
    it 'is invalid without title' do
      secret.title = nil
      expect(secret).to be_invalid
    end
    it 'is invalid without body' do
      secret.body = nil
      expect(secret).to be_invalid
    end
    it 'is invalid without author' do
      secret.author = nil
      expect(secret).to be_invalid
    end
    it 'is valid with title, body, author' do
      expect(secret).to be_valid
    end
  end
  describe 'body length' do
    it 'is invalid if fewer than 4 chars' do
      secret.body = 'bla'
      expect(secret).to be_invalid
    end
    it 'is invalid if more than 140 chars' do
      secret.body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu metus justo. Donec justo justo, accumsan in felis et, commodo orci aliquam.'
      expect(secret).to be_invalid
    end
    it 'is valid if between 4 and 140 chars' do
      secret.body = 'I wonder if this is the right length'
      expect(secret).to be_valid
    end
  end
  describe 'title' do
    it 'is valid if between 4 and 24 chars' do
      secret.title = 'Is this acceptable?'
      expect(secret).to be_valid
    end
    it 'is invalid if < 4 chars' do
      secret.title = 'No'
      expect(secret).to be_invalid
    end
    it 'is invalid if > 24 chars' do
      secret.title = 'And what about this? Is this maybe acceptable? Tell me!'
      expect(secret).to be_invalid
    end
  end
  describe 'instance methods' do
    context 'last_five' do
      let(:secrets) { create_list(:secret, 10) }
      it 'returns 5 posts' do
        secrets
        expect(Secret.last_five.count).to eq(5)
      end
      it 'returns them in descending order' do
        secrets
        last_five = Secret.last_five
        last_five.each_with_index do |s, i|
          unless i == last_five.size - 1
            expect(s.created_at).to be > last_five[i+1].created_at
          end
        end
      end
    end
  end

  describe 'associations' do
    let(:secret){ create(:secret)}
    it 'secret responds to author association' do
      expect(secret).to respond_to(:author)
    end


  end


end

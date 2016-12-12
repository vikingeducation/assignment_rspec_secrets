require 'rails_helper'
describe Secret do

  let ( :secret ) { build(:secret) }

  context 'validations' do
    it 'with title and body is valid' do
      expect(secret).to be_valid
    end

    it 'without title and body is invalid' do
      secret = build(:secret, title: '', body: '')
      expect(secret).to_not be_valid
    end

    it 'title < 4 chars is invalid' do
      secret = build(:secret, title: 'two')
      expect(secret).to_not be_valid
    end

    it 'title > 24 chars is invalid' do
      secret = build(:secret, title: 'twentyfourcharactersohmy!')
      expect(secret).to_not be_valid
    end

    it 'body < 4 chars is invalid' do
      secret = build(:secret, body: 'two')
      expect(secret).to_not be_valid
    end

    it 'body > 140 chars is invalid' do
      secret = build(:secret, body: 'so many characters and more, the quick brown fox jumps over the lazy dog blah blah blah, slackbot is dumb!  some more characters, are you sure this isnt 140 yet?')
      expect(secret).to_not be_valid
    end
  end

  context 'associations' do
    it 'responds to author' do
      expect(secret).to respond_to(:author)
    end
  end

  context 'methods' do
    describe '#last_five' do
      let ( :num_secrets ) { 5 }

      it 'responds to #last_five' do
        expect(Secret).to respond_to(:last_five)
      end

      it 'returns last 5 secrets' do
        secrets = create_list(:secret, num_secrets)
        expect(Secret.last_five).expect include(secrets)
      end
    end
  end
end

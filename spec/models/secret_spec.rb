require 'rails_helper'

describe Secret do

  let(:secret) { build(:secret) }

  it 'has a title, body and author' do
    expect(secret).to be_valid
  end

  it 'is invalid if it does not have a title' do
    secret.title = nil
    expect(secret).to_not be_valid
  end

  it 'is invalid if it does not have a body' do
    secret.body = nil
    expect(secret).to_not be_valid
  end

  it 'is invalid if it does not have an author' do
    secret.author_id = nil
    expect(secret).to_not be_valid
  end

  it 'has a title of length between 4 and 24 chars' do
    expect(secret).to be_valid
  end

  it 'is invalid if title length is less than 4 chars' do
    secret.title = "a"
    expect(secret).to_not be_valid
  end

  it 'is invalid if title length is greater than 24 chars' do
    secret.title = "aasdfdsflkdjsaklfjaeijfdksjafkejsifjksajfiesjafijsifjdisdjis"
    expect(secret).to_not be_valid
  end

  it 'has a body of length between 4 and 140 chars' do
    expect(secret).to be_valid
  end

  it 'is invalid if body length is less than 4 chars' do
    secret.body = "a"
    expect(secret).to_not be_valid
  end

  it 'is invalid if body length is greater than 140 chars' do
    secret.body = "a" * 141
    expect(secret).to_not be_valid
  end

  describe '#last_five' do

    it 'returns 5 entries at most' do
      many_secrets = create_list(:secret, 10)
      last_five_secrets = Secret.last_five
      expect(last_five_secrets.length).to eq(5)
    end

    it 'returns entries in descending order' do
      many_secrets = create_list(:secret, 10)
      last_five_secrets = Secret.last_five
      descending = true

      (last_five_secrets.length-1).times do |index|
        if last_five_secrets[index].id < last_five_secrets[index+1].id
          descending = false
          break
        end
      end

      expect(descending).to be true
    end
  end

end

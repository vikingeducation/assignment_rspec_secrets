# happy
  #has a author, title and body to be valid
  
  #title is valid with between 4 and 24 chars
  #tile is invalid with more than 24 chars and less than 4chars
  
  #body is valid with between 4 and 140 chars
  #body is invalid with less than 4 and more than 140 chars

  #2 secrets can have same author

  #secret should respond to author

  #Secret last_five method returns count of 5



require 'pry'
require 'rails_helper'

describe Secret do

  let(:secret){ build(:secret) }

  it 'is valid with default attributes' do
    expect(secret).to be_valid
  end

  it 'is invalid(does not save) with a title of less than 4 chars' do
    secret.title = "123"
    secret.save
    expect(secret.persisted?).to be_falsy
  end

  it 'is invalid with a title of more than 24 chars' do
    secret.title = "1"*25
    secret.save
    expect(secret.persisted?).to be_falsy
  end

  it 'is valid with a title between 4 and 24 chars' do
    secret.title = "1"*24
    secret.save
    new_secret = create(:secret, :title =>"1"*4)
    expect(secret && new_secret).to be_valid
  end

  it 'is valid with a body between 4 and 140 chars' do
    secret.body = "1"*4
    secret.save
    new_secret = create(:secret, :body => "1"*140)
    expect(new_secret && secret).to be_valid
  end

  it 'is invalid with a body of less than 4 chars' do
    secret.body = "1"*3
    secret.save
    expect(secret).to be_invalid
  end

  it 'is invalid with a body of more than 140 chars' do
    secret.body = "1"*141
    secret.save
    expect(secret).to be_invalid
  end

  specify '2 secrets can have the same author' do
    user = build(:user)
    user.secrets = create_list(:secret, 2)
    user.save!
    expect(user.secrets.count).to eq(2)
  end

  it 'should respond to author' do
    expect(secret).to respond_to(:author)
  end

  context "testing Secret methods" do

    before(:each) do 
        @secrets = create_list(:secret, 6)
    end

    specify "last_five returns 5 secrets" do
      expect(Secret.last_five.count).to be <= 5
    end

    specify "last_five to return last 5 secrets in list" do
      binding.pry
      @secrets = @secrets[0..-2]
      expect(Secret.last_five).to eq(@secrets)
    end

  end

end
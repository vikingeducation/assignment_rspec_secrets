# happy
  #has a author, title and body to be valid
  
  #title is valid with between 4 and 24 chars
  #tile is invalid with more than 24 chars and less than 4chars
  
  #body is valid with between 4 and 140 chars
  #body is invalid with less than 4 and more than 140 chars

  #2 secrets can have same author

  #secret should respond to author

  #Secret last_five mehtod returns count of 5



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

  it ' is invalid with a title of more than 24 chars' do
    secret.title = "1"*25
    secret.save
    expect(secret.persisted?).to be_falsy
  end

  it ' is valid with a title between 4 and 24 chars' do
    secret.title = "1"*24
    new_secret = create(:secret, :title =>"1"*4)
    secret.save
    expect(secret && new_secret).to be_valid
  end

  it 'is valid with a body between 4 and 140 chars'

  it ' is invalid with a body of less than 4 chars'

  it ' is invalid with a body of more than 140 chars'

end
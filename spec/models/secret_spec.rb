require 'rails_helper'

describe Secret do

  it 'has a title'
  it 'is invalid if it does not have a title'
  it 'has a body'
  it 'is invalid if it does not have a body'
  it 'has an author'
  it 'is invalid if it does not have an author'
  it 'has a title of length between 4 and 24 chars'
  it 'is invalid if title length is less than 4 chars'
  it 'is invalid if title length is greater than 24 chars'
  it 'has a body of length between 4 and 140 chars'
  it 'is invalid if body length is less than 4 chars'
  it 'is invalid if body length is greater than 140 chars'

  describe '#last_five' do

    it 'returns 5 entries at most'
    it 'returns entries in descending order'

  end

end
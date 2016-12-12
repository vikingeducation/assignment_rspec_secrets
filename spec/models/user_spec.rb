require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it 'has the default attributes' do
    expect(user).to be_valid
  end

  it 'is invalid if name is not present' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is invalid if email is not present' do
  end

  it 'can have secrets'
  it 'accepts a name of length between 3 and 20 chars'
  it 'is invalid if name length is less than 3 chars'
  it 'is invalid if name length is greater than 20 chars'
  it 'has a unique email'
  it 'is invalid if email is already taken'
  it 'accepts a password with length between 6 and 16 chars'
  it 'is invalid if password length is less than 6 chars'
  it 'is invalid if password length is greater than 16 chars'
  it 'allows nil'

end


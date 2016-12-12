require 'rails_helper'
describe User do
  # validations
  let ( :user ) { build(:user) }

  it 'with name and email is valid' do
    expect(user).to be_valid
  end
  
  it 'without name and email is invalid'
  it 'with name < 3 chars is invalid'
  it 'with name > 20 chars is invalid'
  it 'with repeated email is invalid'
  it 'with password < 6 chars is invalid'
  it 'with password > 16 chars is invalid'

  # associations

  # methods
end

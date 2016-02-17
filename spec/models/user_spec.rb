# Test that user is created with valid email,password, username
# Test that user is not created when parameters are invalid
# Test that user is not created when parameters are not provided
# Test that user responds to .secrets
# Test that we can't create a user with a duplicate email address
require 'rails_helper'

describe User do

  let(:user){ build(:user) }

  describe 'attributes' do
    it 'has valid attributes' do
      expect(user).to be_valid
    end

    it 'saves with valid attributes' do
      expect{ user.save! }.not_to raise_error
    end
  end


end
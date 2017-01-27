require 'rails_helper'

# RSpec.describe User, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe User do 
  let(:user){ build(:user) }

  describe 'basic validations' do
    it 'with default attributes valid' do
      expect(user).to be_valid
    end

    it 'saves default attributes without raising errors' do
      expect{ user.save! }.not_to raise_error
    end
  end

  describe 'name attribute' do 
    it 'without a name is invalid' do
      user = build(:user, :name => nil)
      expect(user).not_to be_valid
    end

    it 'with a name < 3 characters is invalid' do
      user = build(:user, :name => 'a')
      expect(user).not_to be_valid
    end

    it 'with a name of 4 characters is valid' do
      user = build(:user, :name => 'a' * 4 )
      expect(user).to be_valid
    end

    it 'with a name > 20 characters is invalid' do
      user = build(:user, :name => 'a' * 21)
      expect(user).not_to be_valid
    end

    it 'with a name of 20 characters is valid' do
      user = build(:user, :name => 'a' * 20)
      expect(user).to be_valid
    end
  end

  describe 'email attribute' do
    it 'without an email is invalid' do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end

    it 'with a duplicate email is invalid' do
      user.save!
      duplicate = build(:user, :email => user.email )
      expect(duplicate).not_to be_valid
    end
  end

  describe 'password' do
    it 'with a password of 5 characters is invalid' do
      user = build(:user, :password => 'a' * 5)
      expect(user).not_to be_valid
    end

    it 'with a password of 6 characters is valid' do
      user = build(:user, :password => 'a' * 6)
      expect(user).to be_valid
    end

    it 'with a password of 17 characters is invalid' do
      user = build(:user, :password => 'a' * 17)
      expect(user).not_to be_valid
    end

    it 'with a password of 16 characters is valid' do
      user = build(:user, :password => 'a' * 16)
      expect(user).to be_valid
    end
  end

  describe 'secrets associations' do
    it 'responds to secrets association' do
      expect(user).to respond_to(:secrets)
    end
  end

end
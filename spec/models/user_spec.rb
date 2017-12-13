require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name, email, password, and password_confirmation' do
    user = build :user
    expect(user).to be_valid
  end

  describe 'name' do
    it 'is invalid without' do
      user = build :user, name: nil
      user.valid?
      expect(user.errors[:name]).to include "can't be blank"
    end

    it 'is invalid when too short' do
      user = build :user, name: 'IT'
      user.valid?
      expect(user.errors[:name]).to include 'is too short (minimum is 3 characters)'
    end

    it 'is invalid when too long' do
      user = build :user, name: 'Thedude' * 3
      user.valid?
      expect(user.errors[:name]).to include 'is too long (maximum is 20 characters)'
    end
  end

  describe 'email' do
    it 'is invalid without' do
      user = build :user, email: nil
      user.valid?
      expect(user.errors[:email]).to include "can't be blank"
    end

    it 'must be unique' do
      user = create :user
      new_user = build :user, email: user.email

      new_user.valid?
      expect(new_user.errors[:email]).to include 'has already been taken'
    end
  end

  describe 'password' do
    it 'is invalid without' do
      user = build :user, password: nil, password_confirmation: nil
      user.valid?
      expect(user.errors[:password]).to include "can't be blank"
    end

    it "is invalid when doesn't match confirmation" do
      intended_pw = 'TalkinShaft1!'
      user = build :user, password: intended_pw, password_confirmation: 'shutyourmouth'
      user.valid?
      expect(user.errors[:password_confirmation]).to include "doesn't match Password"
    end

    it 'is invalid when too short' do
      too_short = 'Abc'
      user = build :user, password: too_short, password_confirmation: too_short
      user.valid?
      expect(user.errors[:password]).to include 'is too short (minimum is 6 characters)'
    end

    it 'is invalid when too long' do
      too_short = 'a' * 17
      user = build :user, password: too_short, password_confirmation: too_short
      user.valid?
      expect(user.errors[:password]).to include 'is too long (maximum is 16 characters)'
    end
  end
end
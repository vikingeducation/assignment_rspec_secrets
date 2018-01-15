require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }

  describe 'basic validity' do
    it 'test basic validity of users'
  end

  describe "valdations" do
    it "with a name and email is valid" do
      expect(user).to be_valid
    end

    it "without a name is invalid" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "with a name that's too short is invalid" do
      user = build(:user, name: 'A')
      expect(user).not_to be_valid
    end

    it "with a name that's too long is invalid" do
      user = build(:user, name: 'this is longer than 20 characters')
      expect(user).not_to be_valid
    end

    it "without an email address is invalid" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "with a non-unique email address is invalid" do
      user_1 = create(:user)
      user_2 = build(:user, email: user_1.email)
      expect(user_2).not_to be_valid
    end

    it "without a password is invalid" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "with a password that's too short is invalid" do
      user = build(:user, password: '12345')
      expect(user).not_to be_valid
    end

    it "with a password that's too long is invalid" do
      user = build(:user, password: '12345678901234567')
      expect(user).not_to be_valid
    end
  end


  describe 'associations' do
  end

  describe 'model methods' do
  end

end



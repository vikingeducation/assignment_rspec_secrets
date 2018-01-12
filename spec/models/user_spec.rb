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

    xit "without a name is invalid" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    xit "without an email address is invalid" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end
  end


  describe 'associations' do
  end

  describe 'model methods' do
  end

end



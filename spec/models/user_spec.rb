require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }
  let(:name_min){ 3 }
  let(:name_max){ 20 }
  let(:email_min){ 6 }
  let(:email_max){ 16 }

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

    it "with a name that's in the length range is valid" do
      user_1 = build(:user, name: generate_string(name_min))
      user_2 = build(:user, name: generate_string(name_max))
      expect([user_1, user_2]).to all(be_valid)
    end

    it "with a name that's too short is invalid" do
      user = build(:user, name: generate_string(name_min - 1))
      expect(user).not_to be_valid
    end

    it "with a name that's too long is invalid" do
      user = build(:user, name: generate_string(name_max + 1))
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
      user = build(:user, password: generate_string(email_min - 1))
      expect(user).not_to be_valid
    end

    it "with a password that's too long is invalid" do
      user = build(:user, password: generate_string(email_max + 1))
      expect(user).not_to be_valid
    end
  end


  describe 'associations' do
    it "responds to #secrets" do
      expect(user).to respond_to(:secrets)
    end
  end

  describe 'model methods' do
  end

end



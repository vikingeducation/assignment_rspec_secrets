require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user){ build(:user) }

  context "User validations" do

    it 'is valid with a name, email, and password' do
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a name less than 3 characters' do
      user = build(:user, name: "fo")
      expect(user).not_to be_valid
    end

    it 'is invalid with a name more than 20 characters' do
      user = build(:user, name: "i am more than twenty characters blah blah blah")
      expect(user).not_to be_valid
    end

    it 'is invalid with a password less than 6 characters' do
      user = build(:user, password: "passw")
      expect(user).not_to be_valid
    end

    it 'is invalid with a password more than 16 characters' do
      user = build(:user, password: "i am more than twenty characters blah blah blah")
      expect(user).not_to be_valid
    end

    context "when saving multiple users" do
      before do
        user.save!
      end

      it 'is invalid with a non-unique email' do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end
  end
end

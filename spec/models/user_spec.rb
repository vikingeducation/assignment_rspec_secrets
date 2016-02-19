require 'rails_helper'

describe User do

  let(:user){ build(:user) }

  context "validations" do

    it 'with a name, email, and password is valid' do
      expect(user).to be_valid
    end

    it 'without a name is invalid' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'without an email is invalid' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'with a name less than 3 characters is invalid ' do
      user = build(:user, name: "fo")
      expect(user).not_to be_valid
    end

    it 'with a name more than 20 characters is invalid' do
      user = build(:user, name: "i am more than twenty characters blah blah blah")
      expect(user).not_to be_valid
    end

    it 'with a password less than 6 characters is invalid' do
      user = build(:user, password: "passw")
      expect(user).not_to be_valid
    end

    it 'with a password more than 16 characters is invalid' do
      user = build(:user, password: "i am more than twenty characters blah blah blah")
      expect(user).not_to be_valid
    end

    it 'when password confirmation does not match is invalid' do
      user = build(:user, password_confirmation: "not the other one")
      expect(user).not_to be_valid
    end

    it 'when password and confirmation match is valid' do
      user = build(:user, password_confirmation: "password", password: "password")
      expect(user).to be_valid
    end

    context "when saving multiple users" do
      before do
        user.save!
      end

      it 'with a non-unique email is invalid' do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end
  end

  context 'associations' do

    it 'responds to the secrets association' do
      expect(user).to respond_to(:secrets)
    end

    # TODO: add a shouldda matcher for have_many
  end
end

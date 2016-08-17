require 'rails_helper'

describe User do

  describe "Validations" do
    let(:user) { build(:user) }

    it "validates presence of name" do
      is_expected.to validate_presence_of(:name)
    end

    it "has a secure password" do
      is_expected.to have_secure_password
    end

    it "ensures length of name" do
      is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20)
    end

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "is invalid without name" do
      no_name = build(:user, name: "")
      expect(no_name).to_not be_valid
    end

    it "is invalid with short name" do
      no_name = build(:user, name: "as")
      expect(no_name).to_not be_valid
    end

    it "is invalid with duplicate email" do
      user.save
      duplicate_email = build(:user, email: user.email)
      expect(duplicate_email).to_not be_valid
    end

    it "is invalid with short password" do
      short_pw = build(:user, password: "short")
      expect(short_pw).to_not be_valid
    end

  end

  describe "Associations" do
    let(:user) { build(:user) }
    let(:secret) {build(:secret) }

    it "has associated secrets" do
      expect(user).to respond_to(:secrets)
    end

    it "has many secrets" do
      expect(user).to have_many(:secrets)
      #or
      #is_expected.to have_many (:secrets)
    end

  end


    let(:user) { build(:user) }

    it 'with a valid with name, email, and password is valid' do
        expect(user).to be_valid
    end

    it 'without a name is invalid' do
        new_user = build(:user, name: nil)
        expect(new_user).not_to be_valid
    end

    it 'without an email is invalid' do
        new_user = build(:user, email: nil)
        expect(new_user).not_to be_valid
    end

    it 'without a password is invalid' do
        new_user = build(:user, password: nil, password_confirmation: nil)
        expect(new_user).not_to be_valid
    end

    context 'validating attributes for user' do
        before do
            user.save!
        end

        it "doesn't allow identical email addresses" do
            new_user = build(:user, email: user.email)
            expect(new_user).not_to be_valid
        end

        it "doesn't allow name of length < 3" do
            new_user = build(:user, name: 'tw')
            expect(new_user).not_to be_valid
        end

        it "doesn't allow name of length > 20" do
            new_user = build(:user, name: 't' * 21)
            expect(new_user).not_to be_valid
        end

        it "doesn't allow password of length < 6" do
            new_user = build(:user, password: 't' * 5, password_confirmation: 't' * 5)
            expect(new_user).not_to be_valid
        end

        it "doesn't allow password of length > 16" do
            new_user = build(:user, password: 't' * 17, password_confirmation: 't' * 17)
            expect(new_user).not_to be_valid
        end
    end

    context "should have_secure_password" do
      subject{user}
      it { is_expected.to have_secure_password }

      it "doesn't allow user to be saved without matching password and password_confirmation" do
        new_user = build(:user, password: 't' * 10, password_confirmation: 't' * 17)
        expect(new_user).not_to be_valid
      end
    end
end

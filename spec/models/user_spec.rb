require 'rails_helper'

describe User, type: :model do


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

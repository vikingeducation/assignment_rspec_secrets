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

    it 'is not valid if name is blank' do
      new_user = build(:user, name: "")
      expect(new_user).not_to be_valid
    end

    it 'is not valid if email is blank' do
      new_user = build(:user, email: "")
      expect(new_user).not_to be_valid
    end

    it 'is not valid if password is blank' do
      new_user = build(:user, password: "")
      expect(new_user).not_to be_valid
    end

    it 'is valid with a 3 letter name' do
      new_user = build(:user, name: "foo")
      expect(new_user).to be_valid
    end

    it 'is valid with a 20 letter name' do
      new_user = build(:user, name: "reallylongnamesolong")
      expect(new_user).to be_valid
    end

    it 'is invalid with a 21 letter name' do
      new_user = build(:user, name: "reallylongnamesolongl")
      expect(new_user).not_to be_valid
    end

    context "a user is already saved" do
      before do
        test_user = build(:user, email: 'foo@bar.com')
        test_user.save!
      end

      it 'is invalid with an email which is already taken' do
        new_user = build(:user, email: "foo@bar.com")
        expect(new_user).not_to be_valid
      end
    end

    it "is invalid with a 5 letter password" do
      new_user = build(:user, password: "fooba")
      expect(new_user).not_to be_valid
      expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "is valid with a 6 letter password" do
      expect(user).to be_valid
    end

    it "is valid with a 16 letter password" do
      new_user = build(:user, password: "foobarfoobarfoob")
      expect(user).to be_valid
    end

    it "is invalid with a 17 letter password" do
      new_user = build(:user, password: "foobarfoobarfooba")
      expect(new_user).not_to be_valid
      expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "associations" do
    before do
      user.save!
    end

    it "responds to .secrets" do
      expect(user).to respond_to(:secrets)
    end
  end

end

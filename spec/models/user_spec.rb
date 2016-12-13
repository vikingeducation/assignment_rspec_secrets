require 'rails_helper'
describe User do

  let ( :user ) { build(:user) }

  describe "validations" do 
    it 'with name and email is valid' do
      expect(user).to be_valid
    end
    
    it 'without name and email is invalid' do
      user = build(:user, name: "", email: "")
      expect(user).to_not be_valid
    end

    it 'with name < 3 chars is invalid' do
      user = build(:user, name: "it")
      expect(user).to_not be_valid
    end

    it 'with name > 20 chars is invalid' do
      user = build(:user, name: "1234567891011121314151617181920")
      expect(user).to_not be_valid
    end

    it 'with repeated email is invalid' do
      user = create(:user,  email: "example@test.com")
      user2 = build(:user,  email: "example@test.com")
      expect(user2).to_not be_valid
    end

    it 'with password < 6 chars is invalid' do
      user = build(:user,  password: "short")
      expect(user).to_not be_valid
    end

    it 'with password > 16 chars is invalid'  do
      user = build(:user,  password: "longlonglonglonglong")
      expect(user).to_not be_valid
    end
  end

  # associations
  describe "associations" do
    it "responds to secrets" do
      expect(user).to respond_to(:secrets)
    end
  end

  # methods
  describe "methods" do 
    it "have secure password" do
      expect(user).to have_secure_password
    end
  end
end

require 'rails_helper'

describe User do
  
  let(:user){create(:user)}

  describe "attributes" do
    it "with name and email is valid" do
      expect(user).to be_valid
    end
    it "without name is invalid" do
      new_user = build(:user, name: nil, email: "bob@yahoo.com")
      expect(new_user).not_to be_valid
    end
    it "without email is invalid" do
      new_user = build(:user, email: nil)
      expect(new_user).not_to be_valid
    end
  end

  describe "validations" do
    it "with password less than 6 characters is invalid" do
      new_user = build(:user, password: "12345")
      expect(new_user).not_to be_valid
    end
    it "with password greater than 16 characters is invalid" do
      new_user = build(:user, password: "12345678901234567")
      expect(new_user).not_to be_valid
    end
    it "with password between 6 and 16 characters is valid" do
      new_user = build(:user, password: "123456")
      expect(new_user).to be_valid
      new_user = build(:user, password: "asdfghjklpoiuytr")
      expect(new_user).to be_valid
    end
    it "with a duplicate email is invalid" do
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end
    it "with name less than 3 characters is invalid" do
      new_user = build(:user, name: "bo")
      expect(new_user).not_to be_valid
    end
    it "with name more than 20 characters is invalid" do
      new_user = build(:user, name: "mynameisbobbobberstoner")
      expect(new_user).not_to be_valid
    end
    it "with name between 3 and 20 characters is valid" do
      expect(user).to be_valid
    end
  end

  describe "secret associations" do
    let(:secret){build(:secret, author_id: user.id)}
    it "it responds to the secrets association" do
      expect(user).to respond_to(:secrets)
    end
  end

end
# Basic validity - done
# Validations - done
# Associations - done
# Model methods - none

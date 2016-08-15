require 'rails_helper'

describe User do

  let(:user){build(:user)}

  # Validations
  describe "validations" do

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{user.save!}.to_not raise_error
    end

    it "is not vaild if name length is greater than 20 or less than 3" do
      new_user1 = build(:user, :name => "a" * 21)
      expect(new_user1.valid?).to eq(false)
      new_user2 = build(:user, :name => "a" * 2)
      expect(new_user2.valid?).to eq(false)
    end

    it "is not vaild if password length is greater than 16 or less than 6" do
      new_user1 = build(:user, :password => "a" * 17)
      expect(new_user1.valid?).to eq(false)
      new_user2 = build(:user, :password => "a" * 5)
      expect(new_user2.valid?).to eq(false)
    end


    context "when saving multiple users" do
      before { user.save! }

      it "doesn't allow identical email addresses" do
        new_user = build(:user, email: user.email)
        expect(new_user.valid?).to eq(false)
      end
    end
  end


  # Associations
  it "responds to secrets association" do
    expect(user).to respond_to(:secrets)
  end
end

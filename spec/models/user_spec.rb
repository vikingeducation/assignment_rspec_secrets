require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.not_to raise_error
  end

  it "user has an email address" do
    expect(user.email).not_to eq("")
  end

  it "user name has the right number of characters" do
    expect(user.email).not_to eq("")
  end

  it "user name has to be the correct length" do
    expect(user.name.length).to be_between(3,20)
  end

  describe "attributes" do
    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end
  end

  describe "User Associations" do
     it "responds to the posts association" do
      expect(user).to respond_to(:secrets)
    end
  end
end
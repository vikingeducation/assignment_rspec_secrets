require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.not_to raise_error
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
end
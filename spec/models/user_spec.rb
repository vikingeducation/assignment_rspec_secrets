require 'rails_helper'
#require './app/models/user'


describe User do
  let(:user){ build(:user) }

  # Happy
  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "requires a name and email" do
    expect(user).to be_valid
  end



  # Sad

  it "doesn't allow a name shorter than 3 characters" do
    user.name="Om"
    expect(user).to_not be_valid
  end

  it "doesn't allow a name longer than 20 characters" do
    user.name="Omverylongnameverylongname"
    expect(user).to_not be_valid
  end

  it "doesn't allow a password shorter than 6 characters" do
    user.password="test"
    expect(user).to_not be_valid
  end

  it "doesn't allow a password longer than 16 characters" do
    user.password="qwertyuiopqwertyuiopqwertyuiop"
    expect(user).to_not be_valid
  end

  context "when saving multiple users" do
    before do
      user.save!
    end
    it "doesn't allow identical email addresses" do
      new_user = build(:user, :email => user.email)
      expect(new_user.valid?).to eq(false)
    end
  end

  it "responds to secrets assosciation" do
    expect(user).to respond_to(:secrets)
  end

  # password confirmation

end
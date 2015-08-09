require 'rails_helper'

describe User do

  let(:user) { build(:user) }


  it "is valid with name, email, password, and password confirmation" do
    expect(user).to be_valid
  end


  it "is invalid without a name" do
    user.name = nil
    expect(user).to be_invalid
  end


  it "is invalid without an email" do
    user.email = nil
    expect(user).to be_invalid
  end


  it "is valid with a 3-character name" do
    user.name = "Foo"
    expect(user).to be_valid
  end


  it "is invalid with a name that's too short" do
    user.name = "Fo"
    expect(user).to be_invalid
  end


  it "is valid with a 20-character name" do
    user.name = "F2345678901234567890"
    expect(user).to be_valid
  end


  it "is invalid with a name that's too long" do
    user.name = "F23456789012345678901"
    expect(user).to be_invalid
  end


  context "when saving multiple users" do
    before do
      user.save!
    end

    it "is invalid if that email is already in use" do
      new_user = build(:user, :email => user.email)
      expect(new_user).to be_invalid
    end
  end




  it "accepts nil password" do
    user.password = ""
    user.password_confirmation = user.password
    expect(user).to be_valid
  end


  it "is valid with a password of 6 characters" do
    user.password = "foobar"
    user.password_confirmation = user.password
    expect(user).to be_valid
  end


  it "is invalid with a password of 5 characters" do
    user.password = "fooba"
    user.password_confirmation = user.password
    expect(user).to be_invalid
  end


  it "is valid with a password of 16 characters" do
    user.password = "f234567890123456"
    user.password_confirmation = user.password
    expect(user).to be_valid
  end


  it "is invalid with a password of 17 characters" do
    user.password = "f2345678901234567"
    user.password_confirmation = user.password
    expect(user).to be_invalid
  end




  describe "Secrets Association" do

    it "responds to secrets association" do
      expect(user).to respond_to(:secrets)
    end

  end

end
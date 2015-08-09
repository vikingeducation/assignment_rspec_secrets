require 'rails_helper'

describe User do

  it "is valid with name, email, password, and password confirmation"
  it "is invalid without a name"
  it "is invalid without an email"
  it "is valid with a 3-character name"
  it "is invalid with a name that's too short"
  it "is valid with a 20-character name"
  it "is invalid with a name that's too long"
  it "is invalid if that email is already in use"


  it "accepts nil password"
  it "is valid with a password of 6 characters"
  it "is invalid with a password of 5 characters"
  it "is valid with a password of 16 characters"
  it "is invalid with a password of 17 characters"


  describe "Secrets Association" do

    it "responds to secrets association"

  end

end
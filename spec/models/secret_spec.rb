require 'rails_helper'

describe Secret do
  it "with a name and email is valid"
  it "without a name is invalid"
  it "without an email address is invalid"
  it "with a duplicate email address is invalid"
  it "returns a user's name as a string"
end

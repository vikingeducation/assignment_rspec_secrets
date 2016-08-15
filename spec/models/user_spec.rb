require 'rails_helper'

describe User do
  # Validations
  it "is valid with default attributes"
  it "saves with default attributes"
  it "is not vaild if name length is greater than 20 or less than 3"
  it "doesn't allow identical email addresses"
  it "is not vaild if password length is greater than 16 or less than 6"

  # Associations
  it "responds to secrets association"
end
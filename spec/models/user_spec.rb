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

  it "doesn't allow a password shorter than 6 characters"

  it "doesn't allow a password longer than 16 characters"

  it "doesn't allow a duplicate email"

  # Bad

  it "requires a matching password confirmation"

  # password confirmation

end
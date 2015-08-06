require 'rails-helper'

let(:user){ build(:user) }

describe User do

  # Happy

  it "requires a name"

  it "requires an email"

  # Sad

  it "doesn't allow a name shorter than 3 characters"

  it "doesn't allow a name longer than 20 characters"

  it "doesn't allow a password shorter than 6 characters"

  it "doesn't allow a password longer than 16 characters"

  it "doesn't allow a duplicate email"

  # Bad

  it "requires a matching password confirmation"

  # password confirmation

end
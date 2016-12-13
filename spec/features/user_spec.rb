require 'rails_helper'

describe "Visitor actions" do

  context "viewing secrets" do

    it "can view all secrets"

    it "cannot see other users"

  end

  context "signing up" do

    it "successfully adds a user for valid signups"

    it "does not add a user for invalid signups"

  end

end

describe "Authentication" do

  context "with proper credentials" do

    it "allows you to sign in"

  end

  context "with improper credentials" do

    it "does not allow you to sign in"

  end

end

describe "Signed-in user actions" do

  context "working with users" do

    it "can edit themselves"

    it "cannot edit other users"

    it "can delete themselves"

    it "cannot delete other users"

  end

  context "working with secrets" do

    it "can create a secret"

    it "can edit their own secrets"

    it "cannot edit other user's secrets"

    it "can delete their own secrets"

    it "cannot delete other user's secrets"

  end

end
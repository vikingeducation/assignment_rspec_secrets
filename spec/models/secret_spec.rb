require 'rails_helper'

describe Secret do

  it "is valid with a title, body, and author"
  it "is invalid without a title"
  it "is invalid without a body"
  it "is invalid without an author"

  it "is valid with a title of 4 characters"
  it "is invalid with a title of 3 characters"
  it "is valid with a title of 24 characters"
  it "is invalid with a title of 25 characters"

  it "is valid with a body of 4 characters"
  it "is invalid with a body of 3 characters"
  it "is valid with a body of 140 characters"
  it "is invalid with a body of 141 characters"


  describe "#last_five" do

    it "returns 5 secrets if database has >= 5 total secrets"

    it "returns the number of secrets equal to database size if < 5 secrets in total"

  end


  describe "Author Association" do

    it "responds to author association"

    it "is valid if the assigned author is valid"

    it "is invalid if the assigned author is nonexistant"

  end


end
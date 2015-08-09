require 'rails_helper'

describe Secret do

  let (:secret) { build(:secret) }


  it "is valid with a title, body, and author" do
    expect(secret).to be_valid
  end


  it "is invalid without a title" do
    secret.title = nil
    expect(secret).to be_invalid
  end


  it "is invalid without a body" do
    secret.body = nil
    expect(secret).to be_invalid
  end


  it "is invalid without an author" do
    secret.author = nil
    expect(secret).to be_invalid
  end




  it "is valid with a title of 4 characters" do
    secret.title = "Foob"
    expect(secret).to be_valid
  end


  it "is invalid with a title of 3 characters" do
    secret.title = "Foo"
    expect(secret).to be_invalid
  end


  it "is valid with a title of 24 characters" do
    secret.title = "F23456789012345678901234"
    expect(secret).to be_valid
  end


  it "is invalid with a title of 25 characters" do
    secret.title = "F234567890123456789012345"
    expect(secret).to be_invalid
  end




  it "is valid with a body of 4 characters" do
    secret.body = "Foob"
    expect(secret).to be_valid
  end


  it "is invalid with a body of 3 characters" do
    secret.body = "Foo"
    expect(secret).to be_invalid
  end


  it "is valid with a body of 140 characters" do
    secret.body = ""
    140.times { secret.body << "a" }
    expect(secret).to be_valid
  end


  it "is invalid with a body of 141 characters" do
    secret.body = ""
    141.times { secret.body << "a" }
    expect(secret).to be_invalid
  end




  describe "#last_five" do


    it "returns 5 secrets if database has >= 5 total secrets" do
      5.times { create(:secret) }
      expect(Secret.last_five.count).to be(5)
    end


    it "returns the number of secrets equal to database size if < 5 secrets in total" do
      3.times { create(:secret) }
      expect(Secret.last_five.count).to be(3)
    end


  end




  describe "Author Association" do

    it "responds to author association" do
      expect(secret).to respond_to(:author)
    end


    it "is valid if the assigned author is valid" do
      author = create(:user)
      secret.author = author
      expect(secret).to be_valid
    end


    it "is invalid if the assigned author is nonexistant" do
      secret.author_id = 9999999
      expect(secret).to be_invalid
    end


  end


end
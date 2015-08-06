require 'rails_helper'
require 'support/factory_girl'

describe Secret do

  let(:secret){build(:secret)}

  it "is valid" do
    expect(secret).to be_valid
  end

  it "belongs to an author" do
    expect(secret.author).to be_valid
    expect(secret.author).to be_a(User)
    secret= build(:secret, author: nil)
    expect(secret).to_not be_valid
  end

  it "has a title" do
    secret = build(:secret, title: nil)
    expect(secret).to_not be_valid
  end

  it "should have a title between 4 and 24 chars" do
    secret = build(:secret, title: "foo")
    expect(secret).to_not be_valid

    secret = build(:secret, title: "foofoofoofoofoofoofoofoof")
    expect(secret).to_not be_valid

    secret = build(:secret, title: "foofoofoofoofoofoof")
    expect(secret).to be_valid
  end

  it "has a body" do
    secret= build(:secret, body: nil)
    expect(secret).to_not be_valid
  end

  it "should have a body between 4 and 24 chars" do
    secret = build(:secret, body: "foo")
    expect(secret).to_not be_valid

    str = "foo" * 50

    secret = build(:secret, body: str)
    expect(secret).to_not be_valid

    secret = build(:secret, body: "foofoofoofoofoofoof")
    expect(secret).to be_valid
  end

  it "should respond to the last_five class method" do
    expect{Secret.last_five}.to_not raise_error    
  end


end
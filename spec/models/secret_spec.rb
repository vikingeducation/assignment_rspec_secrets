require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }
#Happy
  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "saves with default attributes" do
    expect{secret.save!}.to_not raise_error
  end

#Sad
  it "does not save without a title" do
    secret.title = nil
    expect(secret).to_not be_valid
  end

  it "does not save without a body" do
    secret.body = nil
    expect(secret).to_not be_valid
  end

  it "does not save without a author" do
    secret.author = nil
    expect(secret).to_not be_valid
  end

  it "does not save if the title is less than 4 characters" do
    secret.title = "T"
    expect(secret).to_not be_valid
  end

  it "does not save if title is more than 24 characters" do
    secret.title = "erylonglonglonglonglonglonglongT"
    expect(secret).to_not be_valid
  end

  it "does not save if body is less than 4 characters" do
    secret.title = "Moo"
    expect(secret).to_not be_valid
  end

  it "does not save if body is more than 140 characters" do
    secret.body = "L"*150
    expect(secret).to_not be_valid
  end

  it "responds to author assosciation" do
    expect(secret.author).to respond_to
  end

#Happy
  describe "#last_five" do

    it "shows the 5 secrets created" do
      #user.create_list(:user, 10)
      create_list(:secret, 10)
      expect(Secret.last_five.count).to eq(5)
    end

    it "shows last five in time order" do 
      create_list(:secret, 10)
      
      expect(Secret.last_five.first.id).to eq(Secret.last.id)
    end
  end
  

end
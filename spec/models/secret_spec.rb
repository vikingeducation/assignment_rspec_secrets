require 'rails_helper'


describe Secret do

  let(:secret){build(:secret)}
    it "belongs to author" do
    expect(secret).to respond_to(:author)
  end

  specify "title, author, and body are all present" do
    
    expect(secret).to be_valid

  end

  it "has a title between 4 and 24 chars" do
    
    expect(secret).to be_valid

  end

  it "has a body between 4 and 140 chars" do
    
    expect(secret).to be_valid
    
  end

  describe "#last_five" do
    let!(:secrets){create_list(:secret, 5)}
    it "returns the last 5 secrets when last_five is called" do
      expect(Secret.last_five.count).to eq(5)
    end

    it "returns the secrets in descending order" do
      expect(Secret.last_five.first).to eq(secrets.last)
    end  
  end





end
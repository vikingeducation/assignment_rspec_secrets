require 'rails_helper'

describe Secret do
  let(:user){ create(:user)}
  let(:secret){ build(:secret, :author => user) }

  describe 'valid_default_secret' do 

    it "is valid with default attributes" do
      expect(secret).to be_valid
    end
  end

  describe 'validates_title' do

   it "does not allow a title length of less than 4" do
        new_secret = build(:secret, :title => 'foo')
        expect(new_secret).not_to be_valid
      end

    it "does not allow a title length of more than 24" do
        new_secret = build(:secret, :title => 'f'*25)
        expect(new_secret).not_to be_valid
    end  
  end

  describe 'validates_body' do

   it "does not allow a body length of less than 4" do
        new_secret = build(:secret, :body => 'foo')
        expect(new_secret).not_to be_valid
      end

    it "does not allow a body length of more than 140" do
        new_secret = build(:secret, :body => 'f'*141)
        expect(new_secret).not_to be_valid
    end  
  end

  describe 'checks authors association' do
    it "responds to the authors association" do
      new_secret = build(:secret)
      expect(new_secret).to respond_to(:author)
    end
  end

end
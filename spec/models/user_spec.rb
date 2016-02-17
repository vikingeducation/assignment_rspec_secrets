require 'rails_helper'


describe User do
  
  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end
end
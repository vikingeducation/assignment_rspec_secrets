require 'rails_helper'

describe User do


  let(:author) { build(:author) }


  let(:duplicate_email) do
    create(:duplicate_email)
    build(:duplicate_email)
  end

  let(:num_secrets) { 5 }

  before do
    author.secrets = create_list(:secret, num_secrets)
    author.save!
  end


  it "can have many secrets" do
    expect(author.secrets.count).to eq(num_secrets)
  end


  it "is valid with default attributes" do
    expect(author).to be_valid
  end


  it "does not create user without a name" do
    expect { create(:author, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it "does not create user with duplicate email" do
    expect(duplicate_email).to_not be_valid
  end


  it "does not create user with blank password" do
    expect { create(:author, password: "") }.to raise_error(ActiveRecord::RecordInvalid)
  end



end
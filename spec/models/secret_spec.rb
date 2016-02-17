

require 'rails_helper'

describe Secret do
  # remember you'll need to include the line
  # `config.include FactoryGirl::Syntax::Methods`
  # in your `rails_helper.rb` config to avoid 
  # calling `build` using `FactoryGirl.build`

  let(:our_secret){ build(:secret) }


  it "is valid with default attributes" do
    expect(our_secret).to be_valid
  end

  it "secret author should be User" do
    expect(our_secret.author).to be_instance_of( User )
  end

  it "secret title exists with proper length" do
    expect(our_secret.title.length).to be_within(10.1).of(14.0)
  end

  it "secret body exists with proper length" do
    expect(our_secret.body.length).to be_within(68.1).of(72.0)
  end


  it "title of length 3 is invalid" do
    expect { create(:secret, title: "123") }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it "is not valid without title" do
    expect { create(:secret, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is not valid without body" do
    expect { create(:secret, body: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end


describe "last five" do
  let(:secrets)  do
    NUM_SECRETS = 10
    create_list(:multiple_secrets, NUM_SECRETS) 
    Secret.last_five
  end

  it "returns 5 elts of class Secret" do
    expect(secrets[0]).to be_instance_of( Secret )
    expect(secrets.length).to eq( 5 )
  end

end



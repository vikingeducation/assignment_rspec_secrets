

# describe Secret do
#   it must have author
#   it must have title, 4 .. 24
#   it must have body 4 .. 140
   # ...
# end

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

  it "is valid with default attributes" do
    expect(our_secret.author).to be_instance_of( User )
  end

  it "is valid with default attributes" do
    expect(our_secret.title.length).to be_within(10.1).of(14.0)
  end

  it "is valid with default attributes" do
    expect(our_secret.body.length).to be_within(68.1).of(72.0)
  end

end

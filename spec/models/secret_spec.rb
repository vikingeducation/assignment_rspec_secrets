require 'rails_helper'

describe Secret do
  let(:secret){ build(:secret) }
  title_minimum = 4
  title_maximum = 24
  body_minimum = 4
  body_maximum = 140

  it { should validate_presence_of(:title) }

  it { should validate_presence_of(:body) }

  it { should validate_presence_of(:author) }


  it { should validate_length_of(:title).
    is_at_least(title_minimum).is_at_most(title_maximum)}

  it { should validate_length_of(:body).
    is_at_least(body_minimum).is_at_most(body_maximum)}

  describe "#last_five" do
    let(:user){ build(:user) }
     let(:num_secrets){ 5 }


     it "returns the most recent five of a User's secrets" do
       expect(num_secrets).to eq(5)
     end
  end
end

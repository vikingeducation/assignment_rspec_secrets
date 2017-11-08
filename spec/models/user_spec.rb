require 'rails_helper'

describe User do
  let(:user){ build(:user) }
  name_minimum = 3
  name_maximum = 20
  password_minimum = 6
  password_maximum = 16

  it {should have_secure_password}

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }

  it { should validate_length_of(:name).
    is_at_least(name_minimum).is_at_most(name_maximum)}

  it { should validate_uniqueness_of(:email)}

  it { should validate_presence_of(:password)}

  it { should validate_length_of(:password).
    is_at_least(password_minimum).is_at_most(password_maximum)}

  it "responds to the secrets association" do
        expect(user).to respond_to(:secrets)
      end

end

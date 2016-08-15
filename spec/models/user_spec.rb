require 'rails_helper'

describe User do

  let(:user){ build(:user) }
  let(:bad_email_user){ build(:user, :email => "") }
  let(:bad_password_user){ build(:user, :password => "") }
  let(:second_user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is invalid with no email" do
    expect(bad_email_user).not_to be_valid
  end

  it "is invalid with a non-unique email" do 
    create(:user)
    expect(second_user).not_to be_valid
  end

  it "is invalid with no password" do 
    expect(bad_password_user).not_to be_valid
  end

end
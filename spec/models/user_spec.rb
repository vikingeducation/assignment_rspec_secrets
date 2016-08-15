require 'rails_helper'

describe User do

  let(:user){ build(:user) }
  let(:bad_email_user){ build(:user, :email => "") }
  let(:bad_password_user){ build(:user, :password => "") }
  let(:no_name_user){ build(:user, :name => "") }
  let(:second_user){ build(:user) }
  let(:secret){build(:secret)}


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

  it "is invalid with no name" do
    expect(no_name_user).not_to be_valid
  end

  it "has a 'secrets' method" do
    expect(user).to respond_to(:secrets)
  end

  describe "User association with secrets" do

    it "a valid user can become a secret's author" do
      secret.author = user
      expect(secret).to be_valid
    end

    it "does not allow a non-existent user to become a secret's author" do
      secret.author_id = 1234
      expect(secret).to_not be_valid
    end



  end

  it { is_expected.to have_secure_password }

end
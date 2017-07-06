require 'rails_helper'

describe User do


  #1. Basic Validity
  let(:user){build(:user)}
  let(:secret){build(:secret)}

  it "with a name, email and password is valid" do
    expect(user).to be_valid
  end

  it "without a name is invalid" do
    new_user = build(:user, :name => nil)
    expect(new_user).not_to be_valid
  end

  it "without and email is invalid" do
    new_user = build(:user, :email => nil)
    expect(new_user).not_to be_valid
  end

  it "without password is invalid" do
    new_user = build(:user, :password_digest => nil)
    expect(new_user).not_to be_valid
  end


  it "returns user name as string" do
    new_user = create(:user)
    expect(user.name.class).to be(String)
  end

  it "returns email as string" do
    new_user = create(:user)
    expect(user.email.class).to be(String)
  end

  it "it saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  #2. Validations

  it "with a name shorter than 3 is invalid" do
    new_user = build(:user, :name => ("s"*2))
    expect(new_user).not_to be_valid
  end

  it "with a name longer than 20 is invalid" do
    new_user = build(:user, :name => ("s"*21))
    expect(new_user).not_to be_valid
  end

  it "with password shorter than 6 letters/numbers is invalid" do
    new_user = build(:user, :password => ("s"*5))
    expect(new_user).not_to be_valid
  end

  it "with password longer than 16 etters/numbers is invalid" do
    new_user = build(:user, :password => ("s"*17))
    expect(new_user).not_to be_valid
  end

  it "with password nil is invalid" do
    new_user = build(:user, :password => nil)
    expect(new_user).not_to be_valid
  end


  context "when saving multiple users" do

    before do
      user.save!
    end
    it "with a duplicate email is invalid" do
      new_user = build(:user, :email => user.email)
      expect(new_user).not_to be_valid
    end

  end

  context "when saving multiple users" do

    before do
      user.save!
    end
    it "with a duplicate name is invalid" do
      new_user = build(:user, :name => user.name)
      expect(new_user).not_to be_valid
    end

  end

  # 3.Associations
  it "responds to the secret association" do
    expect(user).to respond_to(:secret)
  end
 
  specify "linking a valid secret succeeds" do
    secret = create(:secret)
    author = secret.author
    expect( author ).to be_valid
  end

  # 4. The Happy / Sad / Bad paths
  describe "Happy Path" do

  end

  describe "Sad Path" do

  end

  describe "Bad Path" do

  end


end

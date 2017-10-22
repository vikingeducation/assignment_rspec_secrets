require 'rails_helper'

describe Secret do

  let(:secret){build(:secret)}
  let(:user){build(:user)}
  let(:secret){build(:secret)}

  #1. Basic Validity
  it "with a title, body, author_id is valid" do
    expect(secret).to be_valid
  end

  it "without a title is invalid" do
    new_secret = build(:secret, :title => nil)
    expect(new_secret).not_to be_valid
  end

  it "without body is invalid" do
    new_secret = build(:secret, :body => nil)
    expect(new_secret).not_to be_valid
  end

  it "without author_id is invalid" do
    new_secret = build(:secret, :author_id => nil)
    expect(new_secret).not_to be_valid
  end


  it "returns title as string" do
    new_secret = create(:secret)
    expect(new_secret.title.class).to be(String)
  end

  it "returns body as string" do
    new_secret = create(:secret)
    expect(new_secret.body.class).to be(String)
  end

  it "it saves with default attributes" do
    expect{ secret.save! }.to_not raise_error
  end


  #2. Validations

  context "when saving multiple secrets" do
    before do
      secret.save!
    end
    it "with a duplicate title is invalid" do
      new_secret = build(:secret, :title => secret.title)
      expect(new_secret).not_to be_valid
    end
  end

  it "with title longer than 24 is invalid" do
    new_secret = build(:secret, :title => ("s"*25))
    expect(new_secret).not_to be_valid
  end

  it "with title shorter than 4 signs it's valid" do
    new_secret = build(:secret, :title => ("s"*3))
    expect(new_secret).not_to be_valid
  end

  it "with body longer than 140 signs it's invalid" do
    new_secret = build(:secret, :body => ("s"*141))
    expect(new_secret).not_to be_valid
  end

  it "with body shorter than 4 signs it's invalid" do
    new_secret = build(:secret, :body => ("s"*3))
    expect(new_secret).not_to be_valid
  end

  # 3.Associations
  it "responds to the user association" do
    expect(secret).to respond_to(:author)
  end

  specify "linking a valid Author succeeds" do
    author = create( :user )
    secret.author = author
    expect( secret ).to be_valid
  end

  specify "linking nonexistent author fails" do
    secret.author_id = 1234
    expect( secret ).not_to be_valid
  end

  # 4.Model methods

  describe ".last_five" do

    let(:num_secrets){5}
    let(:recent_secrects){Secret.ids[-5..-1].reverse}

    before do
      user.secrets = create_list(:secret, 10)
      user.save!
    end
    it "returns the five secrets" do
      expect(Secret.last_five.size).to eq(num_secrets)
    end


    it "returns the last five" do
      expect(Secret.last_five.ids).to eq(recent_secrects)
    end


  end


end

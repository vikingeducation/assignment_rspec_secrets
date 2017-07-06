require 'rails_helper'

describe Secret do

  let(:secret){build(:secret)}
  let(:user){build(:user)}

  #1. Basic Validity
  it "with a title, body, author_id is valid" do
    expect(secret).to be_valid
  end

  it "without a title is invalid" do
    new_secret = build(:secret, :title => nil)
    expect(secret).not_to be_valid
  end

  it "without body is invalid" do
    new_secret = build(:secret, :body => nil)
    expect(secret).not_to be_valid
  end

  it "without author_id is invalid" do
    new_secret = build(:secret, :author_id => nil)
    expect(secret).not_to be_valid
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

  context "when saving multiple users" do
    before do
      secret.save!
    end
    it "with a duplicate title is invalid" do
      new_secret = create(:secret, :title => secret.title)
      expect(secret).not_to be_valid
    end
  end

  it "with title longer than 24 is invalid" do
    new_secret = build(:secret, :title => ("s"*25))
    expect(secret).not_to be_valid
  end

  it "with title shorter than 4 signs it's valid" do
    new_secret = build(:secret, :title => ("s"*3))
    expect(secret).not_to be_valid
  end

  it "with body longer than 140 signs it's invalid" do
    new_secret = build(:secret, :body => ("s"*141))
    expect(secret).not_to be_valid
  end

  it "with body shorter than 4 signs it's invalid" do
    new_secret = create(:secret, :body => ("s"*3))
    expect(secret).not_to be_valid
  end

  # 3.Associations
  it "responds to the user association" do
    expect(secret).to respond_to(:user)
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
  def self.last_five
    order(id: :desc).limit(5)
  end

  describe "#last_five" do

    let(:num_secrets){5}

    before do
      many_secrets = create_list(:secret, 10)
    end

    it "returns the five secrets" do
      expect(many_secrets.last_five).to eq(num_secrets)
    end

    it "returns the last five secrets" do
      last = many_secrets.last_five
      sorted = %w{last}.sort_by { |obj| obj.id}
      expect(last).to eq(sorted)
    end
  end


  # 5. The Happy / Sad / Bad paths

end

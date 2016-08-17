require 'rails_helper'

describe Secret do

  let(:user){create(:user)}
  let(:secret){user.secrets.build(attributes_for(:secret))}
  let(:short_title_secret){user.secrets.build(attributes_for(:secret, :title => "Ow"))}
  let(:short_body_secret){user.secrets.build(attributes_for(:secret, :title => "Ow!"))}
  let(:long_title_secret){user.secrets.build(attributes_for(:secret, :title => "Owwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"))}
  let(:long_body_secret){user.secrets.build(attributes_for(:secret, :title => ("Ow!" * 50)))}
  let(:no_author_secret){build(:secret)}
  let(:no_title_secret){user.secrets.build(attributes_for(:secret, :title => nil))}
  let(:no_body_secret){user.secrets.build(attributes_for(:secret, :body => nil))}

  it "is valid with default attributes" do
    expect(secret).to be_valid
  end

  it "is invalid with a title that is too short" do
    expect(short_title_secret).not_to be_valid
  end

  it "is invalid with a body that is too short" do
    expect(short_body_secret).not_to be_valid
  end

  it "is invalid with a title that is too long" do
    expect(long_title_secret).not_to be_valid
  end

  it "is invalid with a body that is too long" do
    expect(long_body_secret).not_to be_valid
  end

  it "is invalid with no author" do
    expect(no_author_secret).not_to be_valid
  end

  it "is invalid with no title" do
    expect(no_title_secret).not_to be_valid
  end

  it "is invalid with no body" do
    expect(no_body_secret).not_to be_valid
  end

  it "has an author method" do
    expect(secret).to respond_to(:author)
  end

  describe "#last_five_method" do

    

    it "returns 5 secrets if there are 10 secrets created" do
      10.times do |index|
        user.secrets.create(attributes_for(:secret, :title => "secret#{index}"))
      end
      expect(Secret.last_five.size).to eq(5)
    end

    it "returns the latest 5 secrets in reverse order of creation" do
      5.times do |index|
        user.secrets.create(attributes_for(:secret, :title => "secret#{index}"))
      end
      expect(Secret.last_five.first.title).to eq("secret4")
      expect(Secret.last_five.last.title).to eq("secret0")
    end
      


  end




end

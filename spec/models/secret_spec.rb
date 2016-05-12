require 'rails_helper'

describe Secret do
  let( :secret ) { build(:secret) }

  describe "associations" do
    it "responds to the author association" do
      expect(secret).to respond_to(:author)
    end

    it "does not respond to lord association" do
      expect(secret).not_to respond_to(:lord)
    end

    specify "linking an invalid author will be invalid" do
      secret.author_id = 999999
      expect(secret).not_to be_valid
    end

    specify "linking an author that exists will make the secret valid" do
      new_author = create(:user)
      secret.author = new_author
      expect(secret).to be_valid
    end
  end

  describe "attributes" do
    it "is valid with default attributes" do
      expect(secret).to be_valid
    end

    # This is redundant because the above already tells you it's valid but hey, I want the practice.
    it "saves with default attributes" do
      expect { secret.save! }.not_to raise_error
    end

    it "is not valid when title is blank" do
      expect(build(:secret, :title => "")).not_to be_valid
    end

    it "is not valid when body is blank" do
      expect(build(:secret, :body => "")).not_to be_valid
    end

    it "is not valid when author_id is blank" do
      expect(build(:secret, :author_id => nil)).not_to be_valid
    end

    it "is valid when author_id belongs to an author that exists" do
      new_user = create(:user)
      expect(build(:secret, :author_id => new_user.id)).to be_valid
    end

    context "title length" do
      it "is not valid when title is 3 characters long" do
        expect(build(:secret, :title => "123")).not_to be_valid
      end

      it "is valid when title is 4 characters long" do
        expect(build(:secret, :title => "1234")).to be_valid
      end

      it "is valid when title is 24 characters long" do
        expect(build(:secret, :title => ("a" * 24))).to be_valid
      end

      it "is valid when title is 25 characters long" do
        expect(build(:secret, :title => ("a" * 25))).not_to be_valid
      end
    end

    context "body length" do
      it "is not valid when body is 3 characters long" do
        expect(build(:secret, :body => "123")).not_to be_valid
      end

      it "is valid when body is 4 characters long" do
        expect(build(:secret, :body => "1234")).to be_valid
      end

      it "is valid when body is 140 characters long" do
        expect(build(:secret, :body => ("a" * 140))).to be_valid
      end

      it "is not valid when body is 141 characters long" do
        expect(build(:secret, :body => ("a" * 141))).not_to be_valid
      end
    end
  end

  describe "class methods" do
    describe "self.last_five" do

      it "returns a maximum of 5 secrets when there are more than 5 secrets" do
        create_list(:secret, 7)
        expect(Secret.last_five.count).to eq(5)
      end

      it "returns all secrets when there are 5 secrets or less" do
        create_list(:secret, 4)
        expect(Secret.last_five.count).to eq(4)
      end

      it "returns the 5 secrets with the highest id numbers (the last five)" do
        expect(Secret.last_five).to eq(Secret.order(id: :desc).limit(5))
      end
    end
  end
end
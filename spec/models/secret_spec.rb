require "rails_helper"

describe Secret do

  let(:secret){ build(:secret) }
  let(:user){ build(:user) }
  context "validation" do

    it "should be valid with a title, body, and author" do
      expect(secret).to be_valid
    end

    it "should not be valid without a title" do
      secret.title = nil
      expect(secret).not_to be_valid
    end

    it "should not be valid without a body" do
      secret.body = nil
      expect(secret).not_to be_valid
    end

    it "should not be valid without a author" do
      secret.author = nil
      expect(secret).not_to be_valid
    end

    it "should not be valid without a good length title" do
      secret.title = "aaa"
      expect(secret).not_to be_valid

      secret.title = "a" * 25
      expect(secret).not_to be_valid
    end

    it "should not be valid without a good length body" do
      secret.body = "aaa"
      expect(secret).not_to be_valid

      secret.body = "a" * 141
      expect(secret).not_to be_valid
    end
  end

  context "association" do
    it "should respond to author" do
      expect(secret).to respond_to(:author)
    end
  end

  context "classMethod" do
    describe "#last_five" do
      let(:num_secrets){ 5 }
      before do
        user.secrets = create_list(:secret, num_secrets)
      end

      it "should return the last 5 secrets" do
        last_five = Secret.order(id: :desc).limit(5)
        expect(Secret.last_five).to eq(last_five)
      end
    end
  end


end
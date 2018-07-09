require 'rails_helper'

describe Secret do

  let(:secret){build(:secret)}

  describe "validity" do
    it "with title, body and author is valid" do
      expect(secret).to be_valid
    end
  end

  describe "validations" do
    it "without title is invalid" do
      new_secret = build(:secret, title: nil)
      expect(new_secret).not_to be_valid
    end
    it "without body is invalid" do
      new_secret = build(:secret, body: nil)
      expect(new_secret).not_to be_valid
    end
    it "without author is invalid" do
      new_secret = build(:secret, author_id: nil)
      expect(new_secret).not_to be_valid
    end
    it "with less than 4 characters in Title is invalid" do
      new_secret = build(:secret, title: "Boo")
      expect(new_secret).not_to be_valid
    end
    it "with greater than 24 characters in Title is invalid" do
      new_secret = build(:secret, title: "Boohoooooloooohooooohoooo")
      expect(new_secret).not_to be_valid
    end
    it "with 4 characters in the Title is valid" do
      new_secret = build(:secret, title: "jdkf")
      expect(new_secret).to be_valid
    end
    it "with 24 characters in the Title is valid" do
      new_secret = build(:secret, title: "jskdlfkdjskalskdjfkdlsdf")
      expect(new_secret).to be_valid
    end
    it "with less than 4 characters in Body is invalid" do
      new_secret = build(:secret, body: "Boo")
      expect(new_secret).not_to be_valid
    end
    it "with greater than 140 characters in Body is invalid" do
      new_secret = build(:secret, body: "Boohoooooloooohoojas;dlfkj;alksjdf;lakjsdf;lkjasldfaksjdf;lakjsd;flkjas;ldfkj;alskjdf;lakjsd;flkjas;ldkjf;laskjdf;lkajs;ldfja;lskdjf;lakjsd;flkjas;lkdjf;laksjd;flkjas;ldkfj;laskjdf;lkjas;ldfkj;laskjdf;lakjsl;dfkjoawieujrof9mwao;icm;oaimvioaowior;maioroamdfkjxjgwoirjfosjfdlkjfijweooohoooo")
      expect(new_secret).not_to be_valid
    end
    it "with 4 characters in Body is valid" do
      new_secret = build(:secret, body: "1234")
      expect(new_secret).to be_valid
    end
    it "with 140 characters in Body is valid" do
      new_secret = build(:secret, body: "This sentence has to have exactly 140 characters to make this test work perfectly, so I will keep writing until it's exactly 140 characters.")
      expect(new_secret).to be_valid
    end
  end

  describe "author associations" do
    it "responds to author association" do
      expect(secret).to respond_to(:author)
    end
    specify "linking a valid author succeeds" do
      author = build(:user)
      secret.author = author
      expect(secret).to be_valid
    end
    specify "linking w/ a non-existent author fails" do
      secret.author_id = 123432
      expect(secret).not_to be_valid
    end
  end

  describe "model methods" do
    describe "#last_five" do
      let(:secrets) {5}
      let(:less_than_five) {4}
      let(:more_than_five) {6}
      it "returns 5 secrets" do
        secrets_list = create_list(:secret, more_than_five)
        expect(Secret.last_five.count).to eq(secrets)
      end
      it "returns the most recent secrets" do
        secrets_list = create_list(:secret, more_than_five)
        expect(Secret.last_five[0]).to eq(Secret.last)
      end
      it "if less than 5 secrets in DB returns all secrets" do
        secrets_list = create_list(:secret, less_than_five)
        expect(Secret.last_five.count).to eq(Secret.count)
      end
    end
  end


end



# Basic validity - done
# Validations - done
# Associations - done
# Model methods - done 

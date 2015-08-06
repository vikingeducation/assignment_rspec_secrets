# spec/models/user_spec.rb
require 'rails_helper'

describe Secret do

  let(:secret) { build(:secret) }

  context "validations" do

    specify "title must be present" do
      secret.title = nil
      expect(secret).not_to be_valid
    end

    specify "body must be present" do
      secret.body = nil
      expect(secret).not_to be_valid
    end

    specify "author must be present" do
      secret.author = nil
      expect(secret).not_to be_valid
    end

    context "length" do

      describe "title" do

        it "shouldn't be less than 4 characters" do
          secret.title = "foo"
          expect(secret).not_to be_valid
        end

        it "shouldn't be greater than 24 characters" do
          secret.title = "foo" * 9
          expect(secret).not_to be_valid
        end

        it "should be at least 4 characters" do
          secret.title = "fooo"
          expect(secret).to be_valid
        end

        it "should be up to 24 characters" do
          secret.title = "foo" * 8
          expect(secret).to be_valid
        end

      end

      describe "body" do

        it "shouldn't be less than 4 characters" do
          secret.body = "foo"
          expect(secret).not_to be_valid
        end

        it "shouldn't be greater than 140 characters" do
          secret.body = "f" * 141
          expect(secret).not_to be_valid
        end

        it "should be at least 4 characters" do
          secret.body = "fooo"
          expect(secret).to be_valid
        end
        it "should be up to 140 characters" do
          secret.body = "f" * 140
          expect(secret).to be_valid
        end

      end
    end
  end

  context "associations" do

    it "belongs to a user" do
      expect(secret).to respond_to(:author)
    end

  end

  context "methods" do

    describe "#last_five" do

      it "should be an existing method" do
        expect(Secret).to respond_to(:last_five)
      end

      it "should return only one secret if only one exists" do
        secret.save
        expect(Secret.last_five.count).to eq(1)
      end

      it "should return the last five 5 secrets if more than 5 exist" do
        all_secrets = create_list(:secret, 6)
        expect(Secret.last_five).to eq(all_secrets[1..-1].reverse)
      end
    end
  end

end
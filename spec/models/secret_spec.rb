require 'rails_helper'

describe Secret do

	
	let(:secret){ build(:secret) }


	context "(belongs_to) author association" do
	

		# Each secret has an author association
		it "Responds to the author association" do
			expect(secret).to respond_to(:author) 
		end	

	end


	context "title validations" do
		

		# Validates title on presence
		it "Is invalid without a title present" do
			secret = build(:secret, :title => nil)
			expect(secret.valid?).to be(false)	
		end


		# Title length 4..24
		it "Is invalid with a title < 4 characters" do
			secret = build(:secret, :title => "aa")
			expect(secret.valid?).to be(false)
		end


		it "Is invalid with a title > 24 characters" do
			secret = build(:secret, :title => "a"*30)
			expect(secret.valid?).to be(false)
		end


	end
	

	context "body validation" do
		
		# Validates body on presence
		it "Is invalid without a title present" do
			secret = build(:secret, :body => nil)
			expect(secret.valid?).to be(false)	
		end


		# Body length 4..140
		it "Is invalid with a title < 4 characters" do
			secret = build(:secret, :body => "aa")
			expect(secret.valid?).to be(false)
		end


		it "Is invalid with a title > 140 characters" do
			secret = build(:secret, :body => "a"*150)
			expect(secret.valid?).to be(false)
		end
		

	end
	

	context "author_id validations" do
		

		# Validates author_id on presence
		it "Is invalid without a title present" do
			secret = build(:secret, :author_id => nil)
			expect(secret.valid?).to be(false)	
		end


	end
	

	context "self.last_five class method" do
		

		# Make sure self.last_five class method functions
		# properly. Should return last 5 secrets by id
		it "returns five secrets" do
			create_list(:secret, 25)
			expect(Secret.last_five.count).to eq(5)
		end


	end
	

end
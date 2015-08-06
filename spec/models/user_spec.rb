# # Happy paths
# 1. Creation is valid with a name and email
# 2. Creation is valid with unique email 
# 3. Creation requires a password
# 4. Creation requires a password between 6 and 16 characters
# 5. Login is valid with email and password

# # Bad paths

# # Sad paths
# 1. Creation is invalid without a name and email
# 2. Creation is invalid without unique email
# 3. Creation is invalid without a password
# 4. Creation is invalid without a password between 6 and 16 characters
# 5. Cannot process creation without any data
# 6. Login is invalid without and email and password
require 'pry'
require 'rails_helper'

describe User do
	
	let(:user){build(:user)}

	it "is valid with default attributes" do
		expect(user).to be_valid
	end

	it "is valid with a name and email" do 
		expect(user.name && user.email).to_not be_nil 
	end

	it "is invalid without a name and email" do
		new_user = User.new
		expect(new_user).to be_invalid
	end

	it "each user has a unique email" do 
		user1 = build(:user)
		user2 = build(:user)
		expect(user1.email == user2.email).to_not be_truthy
	end
	
	it "is invalid without unique email" do
		user1 = create(:user)
		user2 = User.create(:name => "user2", 
										:email => user1.email,
										:password => "123456")
		expect(user2).to be_invalid
	end
	
	# it "requires a password"
	# it "is invalid without a password"

end
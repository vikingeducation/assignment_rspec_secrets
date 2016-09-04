require 'rails_helper'




describe User do 
  
  let(:user){ build(:user) }
  
  it "is valid with default attributes" do 
    expect(user).to be_valid
  end

  it "with a name between 3 and 20 chars is valid " do
     expect(user).to be_valid

  end
  
  let(:user1){ build(:user, :name => nil) }
  it "without a name is invalid" do
    expect(user1).to_not be_valid
  end

  
  

  it "without a unique email is invalid" do 
    first_user = create(:user, email: "email@email.com")
    user = build(:user, email: "email@email.com" )
    expect(user).to_not be_valid
  end


  
  it "is invalid with a password with the incorrect length" do
    user = build(:user, password: "123" )
    expect(user).to_not be_valid
  end

  it "is valid with a password of the correct length" do
    expect(user).to be_valid
  end 

  it "is invalid without an unique email" do
    user = create(:user, email: "email@email.com")
    user2 = User.create(email: "email@email.com")
    expect(user2).to_not be_valid
  end

  it "responds to secrets" do
    expect(user).to respond_to(:secrets)
  end

  it "validates password" do
    user = build(:user, password: "nil")
    expect{user.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end





end

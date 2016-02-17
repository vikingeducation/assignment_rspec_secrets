
require 'rails_helper'

describe User do
 let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end
end

describe User do
   let(:user){ create(:user) }

   it "does not allow duplicate emails" do
      new_user = build(:user, :email => user.email)
         expect(new_user).not_to be_valid
    end
end

describe User do

 it "does allow a name length of less than 3" do
      new_user = build(:user, :name => 'fo')
        expect(new_user).not_to be_valid
    end

  it "does allow a name length of more than 20" do
      new_user = build(:user, :name => 'foooooooooooooooooooo')
        expect(new_user).not_to be_valid
    end  

end

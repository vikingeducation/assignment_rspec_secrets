<<<<<<< HEAD
=======
# create_table "secrets", force: true do |t|
#   t.string   "title"
#   t.text     "body"
#   t.integer  "author_id"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
#
# create_table "users", force: true do |t|
#   t.string   "name"
#   t.string   "email"
#   t.string   "password_digest"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

>>>>>>> 51eac85445bb119f6b889bafe978b30664ff9edd
require 'rails_helper'

describe User do

<<<<<<< HEAD
  let(:user){build(:user)}

  # Validations
  describe "validations" do

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{user.save!}.to_not raise_error
    end

    it "is not vaild if name length is greater than 20 or less than 3" do
      new_user1 = build(:user, :name => "a" * 21)
      expect(new_user1.valid?).to eq(false)
      new_user2 = build(:user, :name => "a" * 2)
      expect(new_user2.valid?).to eq(false)
    end

    it "is not vaild if password length is greater than 16 or less than 6" do
      new_user1 = build(:user, :password => "a" * 17)
      expect(new_user1.valid?).to eq(false)
      new_user2 = build(:user, :password => "a" * 5)
      expect(new_user2.valid?).to eq(false)
    end


    context "when saving multiple users" do
      before { user.save! }

      it "doesn't allow identical email addresses" do
        new_user = build(:user, email: user.email)
        expect(new_user.valid?).to eq(false)
      end
    end
  end


  # Associations
  it "responds to secrets association" do
    expect(user).to respond_to(:secrets)
  end
=======
  let(:user){ build(:user) }

  it "builds a valid user" do
    expect(user).to be_valid
  end

  it "saves properly" do
    expect{ user.save! }.not_to raise_error
  end



  it "validates email" do
    user = build(:user, email: "")
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates name" do
    user = build(:user, name: "")
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates name length" do
    user = build(:user, name: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates password" do
    user = build(:user, password: "")
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "responds to secret" do
    expect(user).to respond_to(:secrets)
  end

  let(:num_secrets){3}
  before do
    user.secrets = create_list(:secret, num_secrets)
    user.save!
  end
  it "returns the number of a User's secrets" do
    expect(user.secrets.count).to eq(num_secrets)
  end


>>>>>>> 51eac85445bb119f6b889bafe978b30664ff9edd
end

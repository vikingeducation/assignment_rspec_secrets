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

require 'rails_helper'

describe User do

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


end

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

  

end

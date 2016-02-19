require 'rails_helper'

describe "users/index.html.erb" do

  context "visitor" do
    it "cannot see logout link"
  end

  context "logged in user" do
    it "can see logout link"
  end

end

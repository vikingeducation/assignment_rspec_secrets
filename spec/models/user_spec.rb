require 'rails_helper'

describe User do

  describe "Validations" do
    it "validates presence for name and email"
    it "validates the length of the name"
    it "won't save a non-unique email"
    it "validates length of the password"
  end

end

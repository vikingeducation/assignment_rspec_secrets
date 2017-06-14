require "rails_helper"

describe User do
  let(:user){ create(:user) }
  let(:user_attrs){ attributes_for(:user) }

  it "is valid when given all the fields within requirements" do
    new_user = User.new(user_attrs)
    expect( new_user.save! ).to be(true)
  end

  it "fails when not given a name" do
    user_attrs[:name] = nil
    expect(User.new(user_attrs).save).to be(false)
  end

  it "fails when not given an email" do
    user_attrs[:email] = nil
    expect(User.new(user_attrs).save).to be(false)
  end

  it "fails when not given a unique email" do
    user_attrs[:email] = "foo@bar.com"
    User.new(user_attrs).save
    expect(User.new(user_attrs).save).to be(false)
  end

  it "saves with a password between 6..16 chars" do
    pass = easy_pass(1, rand(6..16))
    user_attrs[:password], user_attrs[:password_confirmation] = pass, pass
    expect(User.new(user_attrs).save).to be(true)
  end

  it "fails with a password < 6 chars" do
    pass = easy_pass(1, rand(1..5))
    user_attrs[:password], user_attrs[:password_confirmation] = pass, pass
    expect(User.new(user_attrs).save).to be(false)
  end

  it "fails with a password > 16 chars" do
    pass = easy_pass(1, 17)
    user_attrs[:password], user_attrs[:password_confirmation] = pass, pass
    expect(User.new(user_attrs).save).to be(false)
  end

  it "fails when not given a password" do
    user_attrs[:password], user_attrs[:password_confirmation] = nil, nil
    expect(User.new(user_attrs).save).to be(false)
  end

  it "fails when not given the password confirmation does not match the password" do
    user_attrs[:password] = easy_pass(1, 6)
    user_attrs[:password_confirmation] = easy_pass(2, 6)
    expect(User.new(user_attrs).save).to be(false)
  end

  it "does not fail when not given the password confirmation is blank password" do
    user_attrs[:password] = easy_pass(1, 6)
    user_attrs[:password_confirmation] = nil
    expect(User.new(user_attrs).save!).to be(true)
  end

  it "responds to the `secrets` association" do
    expect(user).to respond_to(:secrets)
  end

end

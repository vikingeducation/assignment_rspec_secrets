require 'rails_helper'

feature "Secret Viewing Not Signed In" do

  before do
    create(:secret)
    visit root_path
  end

  scenario "should see secrets" do
    expect(page).to have_content "Listing secrets"
  end

  scenario "should not see the author unless signed in" do
    expect(page).to have_content "**hidden**"
  end

  scenario "should not see edit destroy links unless signed in" do
    expect(page).not_to have_content "Edit"
    expect(page).not_to have_content "Destroy"
  end

  scenario "should only show 5 secrets" do
    5.times {create(:secret)}
    visit current_path
    expect(page).to have_content("Show", {count: 5})
  end


end

feature "Signing Up" do

  before do
    visit users_path
  end

  scenario "there should be a sign up link" do
    expect(page).to have_content "New User"
  end

  scenario "user should be able to sign up" do
    click_link "New User"

    fill_in "Name", with: "Foo99"
    fill_in "Email", with: "Foo99@bar.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"

    expect{click_button "Create User"}.to change(User, :count).by(1)

    expect(current_path).to eql(user_path(User.first.id))

    expect(page).to have_content 'User was successfully created.'
  end

end

feature "Signing in and out" do

  let(:user) { create(:user) }

  before do
    visit root_path
  end

  scenario "there should be a sign in link" do
    expect(page).to have_content "Login"
  end

  scenario "user should be able to sign in with the right credentials" do
    click_link "Login"

    fill_in "Email",    with: user.email
    fill_in "Password", with: "foobar"

    click_button "Log in"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome, #{user.name}!"
    expect(page).to have_content "Logout"

  end

  scenario 'author names should not be hidden when signed in' do

    sign_in(user)
    new_secret = create(:secret)

    visit current_path

    expect(page).to have_content("#{new_secret.author.name}")
    expect(page).not_to have_content "**hidden**"
    
  end

  scenario 'user should get error when not providing the correct credentials' do
    click_link "Login"

    fill_in "Email",    with: user.email
    fill_in "Password", with: "barfoo"

    click_button "Log in"

    expect(current_path).not_to eq(root_path)
    expect(page).not_to have_content "Welcome, #{user.name}!"
    expect(page).not_to have_content "Logout"
  end


  scenario 'User should see a sign out link when signed in' do
    sign_in(user)

    expect(page).to have_content "Logout"
  end

  scenario 'clicking signout should sign out the user' do
    sign_in(user)

    click_link "Logout"

    expect(current_path).to eql(root_path)
    expect(page).to have_content "Login"
    expect(page).not_to have_content "Welcome, #{user.name}"
  end

end


feature "create a secret as a signed in user" do

  let(:user) { create(:user) }

  before do
     sign_in(user)
  end

  # scenario "we should be signed in" do
  #   expect(current_path).to eq(root_path)
  # end

  scenario "user should be able to create a secret" do
    click_link "New Secret"

    fill_in "Title",    with: "New secret"
    fill_in "Body",     with: "This is a secret"

    expect{click_button "Create Secret"}.to change(Secret, :count).by(1)

    expect(current_path).to eq(secret_path(Secret.first.id))

    expect(page).to have_content("This is a secret")
    expect(page).to have_content("#{user.name}")

  end

end


feature "Editing and deleting secrets" do
  let(:user)   {create(:user)}

  before do 
    create(:secret, author_id: user.id)
    sign_in(user)
  end

  scenario "user should be able to edit his secrets" do
    expect(page).to have_content 'Edit'

    click_link 'Edit'

    fill_in "Title", with: "Edited Title"
    fill_in "Body",  with: "Edited Body"

    expect{click_button "Update Secret"}.to change(Secret, :count).by(0)

    expect(current_path).to eql(secret_path(1))

    expect(page).to have_content "Edited Title"
    expect(page).to have_content "Edited Body"

  end

  scenario 'user should be able to delete his secret' do
    expect(page).to have_content 'Destroy'

    

    expect{click_link 'Destroy'}.to change(Secret, :count).by(-1)

    expect(current_path).to eql(secrets_path)

    # expect(page).to have_content "Edited Title"
    # expect(page).to have_content "Edited Body"
  end
end






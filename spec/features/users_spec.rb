# As a visitor, I want to view all secrets

# As a visitor, I want to sign up
# Blank/invalid attributes invalidate signup
# Already logged-in users should not be able to sign up again

# As a not-signed-in user, I want to sign in to my account
# Blank/invalid inputs
# User doesn't exist

# As a signed-in user, I want to be able to create a secret
# Blank/invalid title or body filled in prevents creating
# visitors shouldn't be able to create

# As a signed-in user, I want to be able to edit one of my secrets
# same as new secret
# shouldn't be able to edit another user's secret

# As a signed-in user, I want to be able to delete one of my secrets
# Shouldn't be able to delete someone else's secret

require 'rails_helper'

feature "View Secrets" do
  before do
    create_list(:secret, 5)
  end

  scenario "visitor viewing secrets sees the secrets" do
    visit(secrets_path)

    expect(page).to have_selector('table tbody tr td')
  end

  scenario "visitor can see a particular secret" do
    body = "I'm a secret"
    create(:secret, body: body)
    visit(secrets_path)

    expect(page).to have_content(body)
  end
end

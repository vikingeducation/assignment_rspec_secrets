require "rails_helper"

def fill_sign_up_form(params)
  fill_in "Name", with: params[:name]
  fill_in "Email", with: params[:email]
  fill_in "Password", with: params[:password]
  fill_in "Password confirmation", with: params[:password]
  click_button "Create User"
end

def fill_secret_form(params)
  fill_in "Title", with: params[:title]
  fill_in "Body", with: params[:body]
  click_button "Create Secret"
end

feature "User events" do
  before do
    create_list(:secret, 5)
    visit root_path
  end

  let(:user){ create(:user) }
  let(:secret){ Secret.first }
  let(:user_attrs){ {name: "Foo Bar", email: "foobar@test.com", password: "foobar"} }

  context "as a visitor" do
    scenario "view all secrets" do
      first_secret = Secret.first
      last_secret = Secret.last

      expect(page).to have_content "Listing secrets"
      expect(page).to have_content first_secret.title
      expect(page).to have_content first_secret.body
      expect(page).to have_content last_secret.title
      expect(page).to have_content last_secret.body
    end

    scenario "sign up" do
      click_link "All Users"
      expect(page).to have_content "Listing users"
      click_link "New User"
      fill_sign_up_form(user_attrs)

      expect(page).to have_content "Welcome, #{user_attrs[:name]}!"
      ## flash msg:
      expect(page).to have_content "User was successfully created."
      expect(page).to have_content user_attrs[:name]
      expect(page).to have_content user_attrs[:email]
    end
  end

  context "as a not signed-in user" do
    scenario "sign in" do
      sign_in(user)
      ## user is redirect to root
      expect(page).to have_content("Welcome, " + user.name + "!")
      expect(page).to have_content "Listing secrets"
    end
  end

  context "as a signed-in user" do
    before do
      user.secrets.build(title: "my title", body: "my body").save!
      sign_in(user)
      visit root_path
    end

    scenario "create a secret" do
      click_link "New Secret"
      expect(page).to have_content "New secret"

      fill_secret_form title: "my title", body: "my body"
      ## user is redirected to the show page
      expect(page).to have_content "Secret was successfully created."
      expect(page).to have_content Secret.last.title
    end

    scenario "edit my secret" do
      find("a[href='#{edit_secret_path(Secret.last.id)}']").click
      expect(page).to have_content "Editing secret"

      fill_in "Title", with: "my new title"
      fill_in "Body", with: "my new body"
      click_button "Update Secret"
      ## flash msg:
      expect(page).to have_content "Secret was successfully updated."
      expect(page).to have_content "my new title"
    end

    scenario "delete my secret" do
      click_link "Destroy"
      ## redirected to root
      expect(page).to have_content "Listing secrets"
      expect(page).not_to have_content "Destroy"
    end
  end

  context "Sad paths" do

    context "not-signed-in user" do
      scenario "sign up without inserting a required field" do
        click_link "All Users"
        click_link "New User"
        ## leave fields empty
        fill_sign_up_form({})

        ## flash msg:
        expect(page).to have_content "Password can't be blank"
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Name is too short (minimum is 3 characters)"
        expect(page).to have_content "Email can't be blank"
        ## styling
        expect(page).to have_css("div.field_with_errors")
      end

      scenario "sign in with wrong password" do
        usr = user
        usr.email = nil
        usr.password = nil
        sign_in(usr)

        expect(!!find_button("Log in")).to be true
      end
    end


    context "signed in user" do
      before do
        sign_in(user)
      end

      scenario "create a secret with no title and body" do
        click_link "New Secret"
        fill_secret_form({})

        ## flash msg:
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Title is too short (minimum is 4 characters)"
        expect(page).to have_content "Body can't be blank"
        expect(page).to have_content "Body is too short (minimum is 4 characters)"
        ## styling
        expect(page).to have_css("div.field_with_errors")
      end

      scenario "view a secret that doesn't exist" do
        expect{visit secret_path(Secret.last.id + 1)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end

end

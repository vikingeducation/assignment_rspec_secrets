require 'rails_helper'

feature 'User' do
  let(:user){ create(:user) }

  context 'Invalid sign in' do

    scenario "cannot login if password doesnt match email" do
      visit root_path
      click_link("Login")
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password + "xxx"
      click_button("Log in")

      expect(page).to have_content "Login"
    end
  end

  context "Valid sign in" do

    before do
      visit root_path
      sign_in(user)
      visit root_path
    end

    scenario "can Log in if valid email and password" do

      expect(page).to have_content "Logout"
    end


    scenario "Can see the new secret form if login" do

      click_link("New Secret")

      expect(page).to have_content "New secret"
    end

    scenario "Can create a new secret" do

      click_link("New Secret")
      fill_in "Title", with: "new secret"
      fill_in "Body", with: "Im a secret body"

      expect{ click_button("Create Secret") }.to change(user.secrets, :count).by(1)
    end


    context "after Creating a Secret" do

      before do
        create_secret
        visit root_path
      end

      scenario "can edit a secret" do

        click_link "Edit"

        expect(page).to have_content "Editing secret"

        fill_in "Title", with: "new secret title"
        fill_in "Body", with: "new secret body"

        click_button("Update Secret")
        expect(page).to have_content "successfully updated"
      end

      scenario "can delete a secret" do
        expect{ click_link "Destroy" }.to change(Secret, :count).by(-1)
      end
    end
  end

end
require 'rails_helper'

describe Secret do
  let(:user){ create(:user) }
  feature "Create Secret" do
    context "Signed in user" do
      before do
        sign_in(user)
        visit new_secret_path
      end

      scenario "invalid body" do
        fill_in "Title", with: "New Secret Test"
        fill_in "Body", with: "#{'l' * 141}"
        click_button "Create Secret"

        expect(page).to have_content "Body is too long"

      end

      scenario "valid body" do
        fill_in "Title", with: "New Secret Test"
        fill_in "Body", with: "#{'l' * 140}"

        expect{click_button "Create Secret"}.to change(Secret, :count).by(1)
        expect(page).to have_content "Secret was successfully created"

      end



    end
    context "Not signed in user" do
      before do
        visit new_secret_path
      end

      scenario "visit new secret page" do
        expect(page).to have_content "Not authorized, please sign in!"
        expect(current_path).to eq new_session_path
      end

    end
  end



  feature "Edit Secret" do
    context "Signed in user" do
      let(:secret){ create(:secret) }
      before do
        sign_in(user)
        visit edit_secret_path(secret)
      end


    end
  end
end

require 'rails_helper'



feature 'Secrets' do
  before do
    visit root_path
  end
  let(:author) { build(:author) }
  let(:secret) { create(:secret) }


  context "as a visitor" do

    scenario "sign up" do
      fill_in_signup(author)
      expect(page).to have_content('User was successfully created')
    end

    scenario "to sign in to my account" do
      author.save!
      sign_in(author)
      expect(page).to have_content("Welcome, #{author.name}!")
    end

    scenario "attempting to make a new secret redirects to login" do
      click_link("New Secret")
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
    end

    context "viewing all users" do
      before do
        author.save
        click_link("All Users")
      end

      scenario "attempting to show user redirects you to login" do
        click_link "Show"
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
      end

      scenario "attempting to edit user redirects you to login" do
        click_link "Edit"
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
      end

      scenario "attempting to destroy user redirects you to login" do
        click_link "Destroy"
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
      end
    end

    context "where there are existing secrets" do
      before do
        author.secrets << create_list(:secret, 10)
        author.save!
        visit root_path
      end

      scenario "view all secrets as a visitor" do
        expect(page).to have_content "Secret Body"
      end

      scenario "shouldn't be able to see authors" do
        expect(page).to have_content "**hidden**"
      end

      scenario "shouldn't be able to see authors on the secret show page" do
        first(:link, "Show").click
        expect(page).to have_content "**hidden**"
      end
    end
  end

  context 'as a signed-in user' do

    before do
      author.save
      sign_in(author)
      click_link("New Secret")
    end

    scenario "be able to create a secret" do
      fill_in_secret(secret)
      expect(page).to have_content('Secret was successfully created.')
    end


      context "while viewing all secrets" do
        before do
          visit root_path
        end

        scenario "without a secret, does not have option to edit/delete secrets" do
          expect(page).not_to have_link('Edit')
        end

        scenario "without a secret, does not have option to edit/delete secrets" do
          expect(page).not_to have_link('Destroy')
        end

        scenario "expect to see secret's authors" do
          expect(page).to have_content(author.name)
        end
      end

    context 'with a secret' do

      before do
        fill_in_secret(secret)
        visit root_path
      end

      scenario "be able to edit one of my secrets" do
        fill_in_edit
        expect(page).to have_content('Secret was successfully updated.')
      end

      scenario "be able to delete one of my secret" do
        click_link "Destroy"
        expect(page).to have_no_content("toodloo")
      end

    end
  end

end

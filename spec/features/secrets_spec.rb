require 'rails_helper'

feature 'Secret' do
	context 'creates a secret' do
			
		let(:user){ create(:user) }

		before do
			sign_in(user)
		end

		scenario 'creates a secret properly' do
			sign_in(user)
			click_link 'New Secret'
			fill_in('secret_title', with: 'New Testing Secret!')
			fill_in('secret_body', with: "More text for the secret.")
			expect{ click_button('Create Secret') }.to change(Secret, :count).by(1)
			expect(page).to have_content("Secret was successfully created.")
		end

		scenario 'edits a secret' do
			sign_in(user)
			click_link 'New Secret'
			fill_in('secret_title', with: 'New Testing Secret!')
			fill_in('secret_body', with: "More text for the secret.")
			click_button('Create Secret')
			click_link('Edit')
			fill_in('secret_title', with: 'Updated Secret Title')
			click_button('Update Secret')
			expect(page).to have_content("Secret was successfully updated.")
		end

		scenario 'deletes a secret' do
			sign_in(user)
			click_link 'New Secret'
			fill_in('secret_title', with: 'New Testing Secret!')
			fill_in('secret_body', with: "More text for the secret.")
			click_button('Create Secret')
			visit root_path
			expect{ click_link 'Destroy' }.to change(Secret, :count).by(-1)
		end

	end

end
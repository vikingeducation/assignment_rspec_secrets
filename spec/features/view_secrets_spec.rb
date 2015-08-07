require 'rails_helper'

feature 'visiting user' do

  before do
    create(:secret)
    visit root_path
  end

  scenario 'can view list of secrets' do
    expect(page).to have_content("Listing secrets")
  end

  scenario 'can see list of all users' do
    click_link "All Users"
    expect(page).to have_content("Listing users")
  end

  scenario 'cannot see the author of the secret' do
    expect(page).to have_content("**hidden**")
    # within_table () do
    #   expect(page).to have_content("**hidden**")
    # end
    # table = find(:xpath, '//table/tbody')
    # binding.pry
    # expect(table).to have_content("**hidden**")
  end

end





#creating secrets
#signed in user can create secret
#non-signed in user cannot create secret

#editing secrets
#signed in user can edit their own secret
#signed in user cannot edit someone else's secret
#visitor cannot edit anyone's secret

#deleting
#signed in user can delete their own secret
#signed in user cannot delete someone else's secret
#visitor cannot delete anyone's secret

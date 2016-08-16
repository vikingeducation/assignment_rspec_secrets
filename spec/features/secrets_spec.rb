require 'rails_helper'

feature 'Secrets' do
  let!(:user) { create(:user) }
  let!(:secret){user.secrets.create(attributes_for(:secret))}

  before do 
    visit(root_path)
  end

  it "Lists secrets on the main page" do 
    expect(page).to have_content("**hidden**")
  end

end
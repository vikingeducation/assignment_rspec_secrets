require 'rails_helper'

describe 'secrets/show.html.erb' do
  before do
    def view.signed_in_user?
      false
    end

    def view.current_user
      false
    end
  end
  scenario 'not-logged-in user cannot see author of a secret' do
    user = create(:user)
    secret = create(:secret)

    assign(:secret, secret)

    render

    expect(rendered).to have_content('**hidden**')
  end
  
end

require 'rails_helper'

describe "secrets/show.html.erb" do

  let(:user) {create(:user, :with_attributes)}
  let(:secret){ create(:secret, :with_attributes, author_id: user.id) }

  before :each do
    def view.signed_in_user?
      false
    end

    def view.current_user
      false
    end
  end

  it "not-logged-in user cannot see author of secret" do
    assign(:secret, secret)
    render
    expect(rendered).to have_content("**hidden**")
  end

end
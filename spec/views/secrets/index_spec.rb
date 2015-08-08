require 'rails_helper'
require 'pry'

describe "secrets/index.html.erb" do

  let(:secret)  { create(:secret) }
  let(:user)    { create(:user) }

  before do
    secrets = [secret, create(:secret)]
    assign(:secrets, secrets)
    def view.signed_in_user?
      false
    end
    def view.current_user
      "text"
    end
  end

  specify "a not logged in user cannot see the author of a secret" do
    # allow(view).to receive(:current_user).and_return(user2)
    # allow(view).to receive(:signed_in_user?).and_return(false)
    render
    expect(rendered).to match('<td>**hidden**</td>\n')
  end

  specify "a logged in user can see the author of secrets"


end
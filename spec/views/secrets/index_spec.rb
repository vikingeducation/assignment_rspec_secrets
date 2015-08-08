require 'rails_helper'
require 'pry'

describe "secrets/index.html.erb" do

  let(:secret)  { create(:secret) }
  let(:secret2) { create(:secret) }
  let(:user)    { create(:user) }

  before do
    secrets = [secret, secret2]
    assign(:secrets, secrets)

    def view.current_user
      "text"
    end
  end

  specify "a not logged in user cannot see the author of a secret" do
    def view.signed_in_user?
      false
    end
    render
    expect(rendered).to match('hidden')
    expect(rendered).to_not match("#{secret.author.name}")
    expect(rendered).to_not match("#{secret2.author.name}")
  end

  specify "a logged in user can see the author of secrets" do 
    def view.signed_in_user?
      true
    end
    render
    expect(rendered).to match("#{secret.author.name}")
    expect(rendered).to match("#{secret2.author.name}")
  end

end
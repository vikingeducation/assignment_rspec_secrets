require "rails_helper"

describe "secrets/index.html.erb" do
  it "does not show the author of a secret to a not-logged-in user" do
    def view.signed_in_user?
      nil
    end
    def view.current_user
      nil
    end
    @secrets = create_list(:secret, 2)
    render
    expect(rendered).to match(/\*\*hidden\*\*/)
  end

  it "shows the author of the secret to a logged-in user" do
    @user = create(:user)
    def view.signed_in_user?
      true
    end
    def view.current_user
      @user
    end
    @secrets = create_list(:secret, 2)
    render
    expect(rendered).to match(/#{@secrets.first.author.name}/)
  end
end

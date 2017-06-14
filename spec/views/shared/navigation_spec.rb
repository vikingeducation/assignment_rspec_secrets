require "rails_helper"

describe "shared/_navigation.html.erb" do
  it "shows a logout link to a logged-in user" do
    @user = create(:user)
    def view.signed_in_user?
      true
    end
    def view.current_user
      @user
    end

    render

    expect(rendered).to match(/Logout/)
  end

  it "shows the login link to a not-logged-in user" do
    def view.signed_in_user?
      nil
    end

    render

    expect(rendered).to match(/Login/)
  end
end

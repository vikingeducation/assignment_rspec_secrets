# spec/views/users/index_spec.rb
require 'rails_helper'


describe "secrets/index.html.erb" do
  it "Verify that a User that is logged in can see the authors of secrets" do
    # get ready to set our instance variable
    user = create(:user)
    secret = create(:secret)
    users = [user, create(:user)]
    secrets = [secret, create(:secret)]

    # Actually set the instance variable.
    # This is identical to writing `@secrets = secrets`
    #   but is more "RSpec-like"
    assign(:secrets, secrets) 

     # Override our helper methods
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
     def current_user
      @current_user = @user
     end
     def sign_in(user)
      session[:user_id] = user.id
      @current_user = user
      true
    end

    # render the view
    render

    expect(rendered).to_not have_content("**hidden**")
    expect(rendered).to have_content(secret.author.name)
  end

  it "Verify that a User that is not logged in can't see the authors of secrets" do
    # get ready to set our instance variable
    user = create(:user)
    secret = create(:secret)
    users = [user, create(:user)]
    secrets = [secret, create(:secret)]

    # Actually set the instance variable.
    # This is identical to writing `@secrets = secrets`
    #   but is more "RSpec-like"
    assign(:secrets, secrets) 

     # Override our helper methods
      def view.signed_in_user?
        false
      end
      def view.current_user
        @user
      end

    # render the view
    render

    # ... HTML style
    expect(rendered).to have_content("**hidden**")
  end
end
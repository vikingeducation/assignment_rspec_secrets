require 'rails_helper'

describe 'secrets/index.html.erb' do

  let(:secret) { create(:secret) }

  describe "visitors and not signed in users" do

    before :each do
      def view.signed_in_user?
        false
      end
      @secret = secret
      def view.current_user
        @secret.author
      end
    end

    it 'does not show secret author for visitor' do
      assign(:secrets, [secret])
      
      render
      expect(rendered).to have_content("hidden")
    end
  end

  describe "signed in users" do
    
    before :each do
      def view.signed_in_user?
        true
      end

      @secret = secret
      def view.current_user
        @secret.author
      end
    end

    it 'shows author of secret for users' do
      assign(:secrets, [secret])
      
      render
      expect(rendered).to have_content("#{@secret.author.name}")
    end
  end

end



# # this line tells spec which template to render
# describe "users/index.html.erb" do

#   it "shows the User's first name" do

#     # get ready to set our instance variable
#     user = create(:user)
#     users = [user, create(:user)]

#     # Actually set the instance variable.
#     # This is identical to writing `@users = users`
#     #   but is more "RSpec-like"
#     assign(:users, users) 

#     # render the view
#     render

#     # Check that it contains our user's first name

#     # ... HTML style
#     expect(rendered).to match('<h1>users index</h1>')

#     # ... CSS style
#     expect(rendered).to have_selector("a[href=\"#{user_path(user)}\"]", :text => "Show #{user.name}")
#   end
# end
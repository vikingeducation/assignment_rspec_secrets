# spec/views/secrets/show_spec.rb
require 'rails_helper'

describe "secrets/show.html.erb" do
  context "when a User is logged out" do
    it "author of the Secret is hidden" do
      @secret = create(:secret)

      render
      expect(rendered).to have_content("**hidden**")
      expect(rendered).to_not have_content(@secret.author.name)
    end
  end

  context "when a User is logged in" do
    before do
      @secret = create(:secret)
      @author = @secret.author

      def view.current_user
        @author
      end
    end

    it "author of the Secret is revealed" do
      render
      expect(rendered).to_not have_content("**hidden**")
      expect(rendered).to have_content(@author.name)
    end
  end
end

require 'rails_helper'

describe "secrets/index.html.erb" do

  context "visitor" do

    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        false
      end
    end

    it "cannot see author of secrets" do

      user = create(:user)
      create(:secret, author: user)
      assign(:secrets, Secret.all)

      render

      expect(rendered).to have_content "**hidden**"
    end
  end

  context "logged in user" do

    let(:user) { create(:user) }
    let(:secret) { create(:secret, author: user) }

    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        user
      end


    end
    
    before { user }


    it "can see author of secrets" do

      assign(:secrets, Secret.all)

      render

      expect(rendered).to_not have_content "**hidden**"
      expect(rendered).to have_content "Foo"

    end
  end

end

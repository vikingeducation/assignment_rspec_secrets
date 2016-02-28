require 'rails_helper'

describe "secrets/show.html.erb" do

  context "logged in user" do
    let(:user){ create(:user) }

    before do
      def view.signed_in_user?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it "shows the authors of a secret" do
      secret = create(:secret)
      assign(:secret, secret)
      render

      expect(rendered).not_to have_content("**hidden**")
    end
  end

  context "not logged in user" do

    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end

    it "hides the authors of a secret" do
      secret = create(:secret)
      assign(:secret, secret)
      render

      expect(rendered).to have_content("**hidden**")
    end
  end
end
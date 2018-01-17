require 'rails_helper'

describe "secrets/index.html.erb" do
  let(:user){create(:user)}
  let(:secret){create(:secret)}
  let(:secrets){[secret, create(:secret)]}

  context "a visitor" do
    before do
      @user = user
      def view.current_user
        @user
      end
      def view.signed_in_user?
        false
      end
    end
    it "cannot see the secret author's name" do
      assign(:secrets, secrets)
      render
      expect(rendered).to have_content('**hidden**')
    end
  end #visitor

  describe "a signed-in user" do
    before do
      @user = user
      def view.current_user
        @user
      end
      def view.signed_in_user?
        true
      end
    end

    it "can see the secret author's name" do
      assign(:secrets, secrets)
      render
      expect(rendered).to have_content(secrets.last.author.name)
    end
  end #signed-in user

end

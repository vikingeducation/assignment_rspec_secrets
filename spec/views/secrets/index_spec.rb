require 'rails_helper'
require 'pry'

describe 'secrets/index.html.erb' do

  let(:user){create(:user)}
  let(:another_user){create(:user)}
  let(:secret){create(:secret, :author => user)}
  let(:secret_two){create(:secret, :author => another_user)}
  let(:secret_three){create(:secret, :author => another_user)}
  let(:secrets){[secret, secret_two, secret_three]}
  let(:users){[user, another_user]}

  before do
    assign(:user, user)
    assign(:users, users)
    assign(:secrets, secrets)
  end

  context "the user is logged-in" do
    before do
      def view.signed_in_user?
        true
      end
      @user = user
      def view.current_user
        @user
      end
    end
    it "shows the author of all secrets" do
      render
      expect(rendered).not_to have_content "**hidden**"
    end
  end

  context "the user is NOT logged-in" do
    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end
    it "doesn't show the authors of all secrets" do
      render
      expect(rendered).to have_content "**hidden**"
    end
  end

end

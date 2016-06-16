require 'rails_helper'

describe 'secrets/index.html.erb' do 

  let(:user){ create(:user, name: "john") }
  let(:secret){ create(:secret, author: user) }
  let(:secrets){ [secret, create(:secret)] }

  before do
    def view.signed_in_user?
      true
    end

    def view.current_user
      "placeholder"
    end

    assign(:secrets, secrets)
  end

  context "Signed in" do

    it "should see the authors name" do
      render

      expect(rendered).to match("john")
    end
  end

  context 'Visitor' do

    before do
      def view.signed_in_user?
        false
      end
    end

    it "should show a hidden text" do
      render
      
      expect(rendered).to match /hidden/
    end

    it "should not see the author name" do
      render

      expect(rendered).not_to match "john"
    end
  end
end
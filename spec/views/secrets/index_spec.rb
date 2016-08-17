require 'rails_helper'

describe 'secrets/index.html.erb' do
  let(:secrets) { create_list(:secret, 5) }
  before do
    assign(:secrets, secrets)
    def view.current_user
      nil
    end
  end

  context "user is not signed in" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "doesn't show the author names" do
      render
      expect(rendered).to match(/\*\*hidden\*\*/)
    end
  end

  context "user is signed in" do
    before do
      def view.signed_in_user?
        true
      end
    end
    it "shows author names" do
      render
      secrets.each do |secret|
        expect(rendered).to match("<td>#{secret.author.name}</td>")
      end
    end
  end


end

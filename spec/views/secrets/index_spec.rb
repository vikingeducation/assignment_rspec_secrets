require 'rails_helper'

describe 'secrets/index.html.erb' do
  let(:user){ create(:user) }
  before do
    @user = user
    def view.current_user
      @user
    end

  end


  describe "visitor" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "hides the secret author's name" do
      @secrets = [create(:secret)]
      render
      expect(rendered).to have_content("hidden")
    end

  end

  describe "user" do
    before do
      def view.signed_in_user?
        true
      end
    end

    it "shows the secret author's name" do
      session[:user_id] = @user.id
      @secrets = [create(:secret, author: @user)]
      render
      expect(rendered).to have_content(@user.name)
    end

  end

  # what does expect(view) do?
  # can you render partials inside of another view
end

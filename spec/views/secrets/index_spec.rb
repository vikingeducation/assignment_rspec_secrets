require 'rails_helper'
describe 'secrets/index.html.erb' do

  let!(:user) {create(:user)}
  before :each do
    assign(:user, user)

    secrets = []
    10.times do 
      secrets << user.secrets.create(attributes_for(:secret))
    end
    assign(:secrets, secrets)

    def view.current_user
      @user
    end
  end

  context 'as a logged in user' do
    before do
      def view.signed_in_user?
        true
      end
      session[:id] = user.id
    end

    it "show the author name of a secret" do
      render

      expect(rendered).to have_content(user.name)
    end

    it "show logout page" do
      render :template => 'secrets/index', :layout => 'layouts/application'

      expect(rendered).to have_link('Logout')
    end

  end

  context 'as a visitor' do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "does not show the author name of a secret" do
      render

      expect(rendered).to have_content('**hidden**')
    end

    it "does not show logout page" do
      render

      expect(rendered).not_to have_link('Logout')
    end
    
  end


end
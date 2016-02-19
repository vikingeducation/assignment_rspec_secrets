# spec/views/users/index_spec.rb
require 'rails_helper'

describe "users/index.html.erb" do

  let(:users){create_list(:user, 2)}
  let(:secret){create(:secret, author: users[0])}
  
  before :each do
    def view.signed_in_user?
      true
    end

    def view.current_user
      @users[0]
    end

  end

  it "does shows logout for authorized user" do
    
    assign(:users, users) 
    
    render template: 'users/index' , layout: 'layouts/application'

    expect(rendered).to have_content('Logout')

  end

  it "does shows login for unsigned user" do
 
    def view.signed_in_user?
      false
    end

    def view.current_user
      @users[0]
    end
   
    assign(:users, users) 
    
    render template: 'users/index' , layout: 'layouts/application'

    expect(rendered).to have_content('Login')

  end
end
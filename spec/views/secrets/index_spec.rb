# spec/views/users/index_spec.rb
require 'rails_helper'

describe "secrets/index.html.erb" do

  let(:users){create_list(:user, 2)}
  let(:secrets){create_list(:secret, 2, author: users[0])}
  
  before :each do
    def view.signed_in_user?
      false
    end

    def view.current_user
      nil
    end

  end

  it "does not show the secrets for unauthorized user" do

    assign(:users, users) 
    assign(:secrets, secrets) 

    render

    expect(rendered).to have_content('**hidden**')

  end
  
end
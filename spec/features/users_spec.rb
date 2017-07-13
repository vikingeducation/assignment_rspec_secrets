require 'rails helper'

feature 'Viewing secrets as visitor' do
  before do
    visit root_path
  end

end


feature 'Signing up as visitor' do
  before do
    visit root_path
  end

end

feature 'Signing in to an account' do
  before do
    visit root_path
  end

end

feature 'Creating secret as signed in user' do
  before do
    visit root_path
  end

end

feature 'Editing secret as signed in user' do
  before do
    visit root_path
  end

end


feature 'Deleting secret as signed in user' do
  before do
    visit root_path
  end

end

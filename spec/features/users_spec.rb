require 'rails helper'

feature 'Actions as visitor' do
  before do
    visit root_path
  end

  context "viewing secrets" do

  end

  context "unable to create secrets" do

  end

  context "unable to see author of a secret" do

  end

end


feature 'Signing up as visitor' do
  before do
    visit root_path
  end

  context "with improper name" do

  end

  context "with improper email" do

  end

  context "with improper password" do

  end

  context "with no password confirmation" do

  end

  context "with some fields empty" do

  end

end

feature 'Signing in to an account' do
  before do
    visit root_path
  end

  context "with improper email" do

  end

  context "with improper password" do

  end

end

feature 'Creating secret as signed in user' do
  before do
    visit root_path
  end

  context "with improper title" do

  end

  context "with improper body" do

  end

  context "with body missing" do

  end

end

feature 'Editing secret as signed in user' do
  before do
    visit root_path
  end

  context "with improper title" do

  end

  context "with improper body" do

  end

end


feature 'Deleting secret as signed in user' do
  before do
    visit root_path
  end

  context "deleting own secret" do

  end

  context "unable to delet other's secret" do

  end

end

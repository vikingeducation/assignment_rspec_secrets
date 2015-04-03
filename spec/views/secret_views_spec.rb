require 'rails_helper'

describe 'Secret Index' do
  context 'when a user is not logged in' do
    specify 'they see a Log In link'
    specify 'they cannot soo th author of a secret'
  end
  context 'when a user is logged in' do
    specify 'they see a Log Out link'
    specify 'they see the author of a secret'
  end
end

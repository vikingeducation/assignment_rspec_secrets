require 'rails_helper'

feature 'Secrets' do

  scenario 'when signed out, lists all secrets when navigating to root path' do
    # go to root path
    # check to see if it lists all secrets
    visit ('/')
  end

  scenario 'when signed out, allows visitor to sign up'
  scenario 'when trying to sign up with blank name field, rerenders the sign up form with error messages'
  scenario 'when trying to sign up with blank email field, rerenders the sign up form with error messages'

  scenario 'when signed out, allows user to log in'

  scenario 'when signed in, allows user to create a secret'
  scenario 'when trying to create a blank secret, rerenders the secret form with error messages'

  scenario 'when signed in, allows user to edit his own secret'
  scenario 'does not allow suer to edit another user\'s secret'

  scenario 'when signed in, allows user to delete his own secret'
  scenario 'does not allow user to delete another user\'s secret'

end
module Macros

  module Secret

    def secret
      visit new_secret_path
      fill_in 'Title', with: 'Secret T'
      fill_in 'Body', with: 'Secret B'
      click_button 'Create Secret'
    end

  end

end

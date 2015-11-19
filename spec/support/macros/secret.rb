module Macros
  module Secret
    def hidden_text
      '**hidden**'
    end

    def secrets_listing_has_edit_links?
      page.all('tbody tr td:nth-child(5) a').present?
    end

    def secrets_listing_has_destroy_links?
      page.all('tbody tr td:nth-child(6) a').present?
    end

    def secrets_listing_author_hidden?
      page.all('tbody tr td:nth-child(3)').all? do |td|
        td.has_content?(hidden_text)
      end
    end

    def secrets_listing_has_action_links_for?(author, action)
      page.all('tbody tr').all? do |tr|
        td = tr.find('td:nth-child(3)')
        if td.has_content?(author.name)
          !!tr.find('td a', :text => action.capitalize)
        else
          !tr.has_css?('td:nth-child(5)')
        end
      end
    end
  end
end

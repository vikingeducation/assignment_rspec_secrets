module Macros
  module Flash
    def success_text_for(object, action)
      object = object.class.name unless object.is_a?(String)
      action += action.to_s == 'destroy' ? 'ed' : 'd'
      "#{object} was successfully #{action}."
    end

    def error_text_for(object)
      object = object.class.name unless object.is_a?(String)
      "prohibited this #{object.downcase} from being saved"
    end
  end
end
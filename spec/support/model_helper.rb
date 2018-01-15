module ModelHelper

  def generate_string(qty)
    str = ''
    qty.times { str += 'x' }
    str
  end

end

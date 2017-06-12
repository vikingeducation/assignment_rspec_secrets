module CommonHelpers

  def repeat(x, n)
    acc = []
    n.times{ acc << x }
    acc
  end

  def easy_pass(x, len)
    repeat(x, len).map(&:to_s).join
  end

  def make_string(char, len)
    repeat(char, len).map(&:to_s).join
  end


end

RSpec.configure do |config|
  config.include CommonHelpers
end

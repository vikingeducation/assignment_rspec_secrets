RSpec.configure do |config|
  # config.before(:suite) { FactoryBot.reload }

  config.include FactoryBot::Syntax::Methods
end

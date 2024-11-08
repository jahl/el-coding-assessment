
module AuthHelper
  include Auth::JwtTokenGenerator

  def auth_headers(user)
    token = generate_token(user)
    { 'Authorization': "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :request
end
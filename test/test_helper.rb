require 'dotenv/load'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'email_octopus'

require 'minitest/autorun'

## Put api_key from environment
EmailOctopus.configure do |config|
  config.api_key = ENV['EMAIL_OCTOPUS_API_KEY']
end
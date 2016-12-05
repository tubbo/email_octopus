# frozen_string_literal: true
require 'email_octopus/version'
require 'email_octopus/api'
require 'email_octopus/model'
require 'email_octopus/campaign'
require 'email_octopus/list'
require 'email_octopus/contact'
require 'email_octopus/config'

# The EmailOctopus API
#
# https://emailoctopus.com/api-documentation/
module EmailOctopus
  # Configuration for the library.
  def self.config
    @config ||= Config.new
  end

  # Apply configuration.
  def self.configure
    yield config
  end

  # HTTP gateway used by the application
  def self.gateway
    @gateway ||= Gateway.new config
  end

  # Can be used in testing to set a mock object as the gateway
  def self.gateway=(new_gateway)
    @gateway = new_gateway
  end
end

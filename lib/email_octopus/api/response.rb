# frozen_string_literal: true
require 'net/http'
require 'json'
require 'forwardable'
require 'email_octopus/api/error'

module EmailOctopus
  class API
    # Response object that parses out JSON.
    class Response
      extend Forwardable

      def initialize(response)
        @raw = response
        raise error_class, self if error?
      end

      def status
        @raw.status
      end

      def headers
        @raw.headers
      end

      def success?
        @raw.is_a? Net::HTTPSuccess
      end

      def error?
        !success?
      end

      def body
        JSON.parse @raw.body
      end

      def error_class
        return unless error?
        case body['code']
        when 'INVALID_PARAMETERS'
          Error::InvalidParameters
        when 'API_KEY_INVALID'
          Error::ApiKeyInvalid
        when 'UNAUTHORISED'
          Error::Unauthorized
        when 'NOT_FOUND'
          Error::NotFound
        else
          Error
        end
      end
    end
  end
end

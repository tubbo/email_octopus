# frozen_string_literal: true

module EmailOctopus
  class API
    # Response object that parses out JSON.
    class Response
      delegate :status, :headers, to: :@raw

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
        @raw.is_a? HTTParty::Response
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
          EmailOctopus::API::Error
        end
      end
    end
  end
end

# frozen_string_literal: true

module EmailOctopus
  class API
    # Base error class, also thrown when unknown errors occur.
    class Error < StandardError
      # Thrown when parameters are invalid.
      class InvalidParameters < Error; end

      # Thrown when API key is invalid.
      class ApiKeyInvalid < Error; end

      # Thrown when user cannot access resource.
      class Unauthorized < Error; end

      # Thrown when resource cannot be found.
      class NotFound < Error; end

      def initialize(response)
        @response = response
        super @response.body['message']
      end
    end
  end
end

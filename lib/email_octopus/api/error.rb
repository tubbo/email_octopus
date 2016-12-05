# frozen_string_literal: true

module EmailOctopus
  class API
    # Base error class, also thrown when unknown errors occur.
    class Error < StandardError
      # @param response [EmailOctopus::API::Response] Original response.
      def initialize(response)
        @response = response
        super @response.body['message']
      end
    end
  end
end

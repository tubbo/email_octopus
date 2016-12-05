# frozen_string_literal: true
module EmailOctopus
  class API
    class Error < StandardError
      # Thrown when API key is invalid.
      class ApiKeyInvalid < Error
      end
    end
  end
end

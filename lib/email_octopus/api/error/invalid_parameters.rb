# frozen_string_literal: true
module EmailOctopus
  class API
    class Error < StandardError
      # Thrown when parameters are invalid.
      class InvalidParameters < Error
      end
    end
  end
end
